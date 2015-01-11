Why Git?
--------

I'm going to use Git a fair bit as a way of distributing
and gathering work, and it is natural to ask why. Isn't
this a course about high-performance computing?

The answer is simply that it is inconceivable to think
about doing any kind of professional software development
without some kind of source-code or change management
software. Performance optimisation is by nature
progressive, so we need the ability to:

- Track changes that are being made, and which
  changes improve performance.
  
- Roll back changes which break the software, as
  often optimisations lead to subtle bugs.
  
- Provide a safe place to work on the next release
  of a project, while still maintaining the current

While there are other source-code managers (SVN, Mercurial,
etc.), Git is very commonly used, and is used
in many large companies and important open-source
projects (not least the linux kernel).

So my goal is not to turn you into a Git expert
(I am not one myself - I use CVS because I am old
and lazy), but to at least expose you to the
key concepts and ideas.

Why Github?
-----------

[GitHub](https://github.com) is a commercial company
which provides hosting of repositories, as well as
custom web and desktop GUI tools for interacting
with them. However, other companies do exist, such
as GitLab, Gitorious, Bitbucket, and so on. We
could also set up an in-house server, using open
source versions of the software.

So the key reasons for using GitHub over another
provider or an in-house git server are:

- Availability: I trust GitHub to keep their servers
  up more than I do myself or ICT with a virtual server.
  
- Experience: This is a widely used platform in open
  source projects, as well as many commercial projects.
  GitHub is big.

- Cost: They provide free licenses for academia :)

Git Clients
-----------

Performing git operations requires some sort of git client.
There are a huge number of possible clients, depending on
whether you want to work on the command line, or want
a GUI. Recommended (free) clients are:

- Windows:

    - [GitHub for Windows](https://windows.github.com) Provides a
      full GUI for managing local sandboxes, and is well integrated
      with github.

    - [TortoiseGIT](https://code.google.com/p/tortoisegit) Another
       GUI interface, well integrated into explorer using context menus.

- Mac:

    - [GitHub for Mac](https://mac.github.com/) A GUI from GitHub
      designed for Mac; well integrated with the file-system and github.
      
- Cross-platform:

    - [git](http://git-scm.com) This is the reference command-line
       version, and works on all platforms (including Windows, via cygwin).
    
    - [git-gui](http://git-scm.com) A cross-platform GUI that also
        comes with the reference tools (though to be honest, if
        you want a GUI on Windows or Mac I'd suggest something
        more specific).

There is something to be said for working on
the command line, and a nice thing about git
is that you can generally switch from the GUI
to the command line depending how you feel.
For now, I would suggest sticking to the GUIs
though.

Documentation on Git
--------------------

There are a million tutorials on Git, all aimed at
different people. The majority focus on the core
concepts using the command line primitives, but
the same operations are available through GUIs.

A few I would recommend are:

- [Try Git](http://try.github.com/) I'm a fan of
  interactive learning, so I particularly like this
  browser-based tutorial (about 15 minutes).

- [Git - the simple Guide](http://rogerdudler.github.io/git-guide/)
  This is a _very_ short introduction to Git, takes
  5 minutes to read. How much you learn...?
  
- [Git Succinctly](http://code.tutsplus.com/series/git-succinctly--net-33581)
  This is actually an e-book that you can download,
  which goes into a little more detail of the
  underlying concepts.

- [Pro Git](http://git-scm.com/book/en/v2) This is
  a full reference manual for Git, describing the
  whole thing in a _lot_ of detail. It does a very
  good job of explaining the concepts with diagrams
  and examples, but is necessarily quite long.

