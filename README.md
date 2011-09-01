# Git autotest
#### Auto test Git repositories after commiting

Makes it so that every time you commit to a Git repo, you'll get a 
Growl/Libnotify notification telling you if your tests pass or fail.

Installation
------------

Check me out somewhere then run `make install`.

    $ git checkout git://github.com/rstacruz/git-autotest
    $ cd git-autotest
    $ make install

...or just add the `bin/` to your `$PATH`. Whatever you like, soldier.

Usage
-----

Enable it on a Git repo:

``` bash
$ git autotest install
```

If you use something else other than `rake test` as a test command, instead use:

``` bash
$ git autotest install "rake spec"    # or whatevs
```

Now commit something:

``` bash
$ touch file.txt
$ git commit -a -m "Yo."
```

You'll get growl/libnotify notifications! Hooray!

How does it work?
-----------------

This is the simplest autotester yet.

### On install

When you install (`git autotest install`) it, it does:

 - Set the autotest command to what you specify (defaults to `rake test`).
 You'll find this in `.git/config`.
 - Adds a post-commit hook to run the tests (`git autotest run`).
 - Ignores `test.log` in that repository.

### On commit

When you commit something in your repository, it invokes the post-commit hook.
What that does is:

 - Send a Growl notification "Running tests..."
 - Invoke the autotest command in the background. Output is piped onto 
 `test.log`.
 - If the test command returns an exit code of 0,
    - Send a Growl notification saying "Tests are okay"
 - If the test command returns an exit code of non-zero,
    - Send a Growl notification saying "Tests failed."

This is a *post*-commit hook. It's invoked in the background after a commit 
happens. It will not stop you from committing if tests fail.

What if I want to stop the commit if tests fail?
------------------------------------------------

*git-autotest* doesn't let you do that. However, that's really really easy and 
you don't need any tools to do that:

``` shell
$ echo "rake test" >> .git/hooks/pre-commit
```


Requirements
------------

  - in Mac OSX: [growlnotify][growlnotify]
  - in Ubuntu: libnotify (which already comes installed in the desktop edition)

[growlnotify]: http://growl.info/extras.php#growlnotify
