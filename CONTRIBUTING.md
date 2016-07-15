### Disclaimer

The source code and assets for this website are distributed as [free software](https://www.gnu.org/philosophy/free-sw.html) and [free culture](https://en.wikipedia.org/wiki/Free_culture_movement).

As a contributor, you agree that all contributions to the source tree, wiki, and issue tracker that are unlicensed and not in the public domain will automatically fall under the same appropriate licence as this website: ([LGPL3](LICENSE.md) for source code, [CC BY-SA 4.0](Assets/README.md)) for images and audio, and [GNU-FDL](Doc/README.md) for documentation.

In short, this means that you allow others to copy, distribute, and modify their copies or your work as long as they extend this priviledge to others and credit you as the original author.

If you are not the sole author of your contribution (i.e. it is a combined or derivative work incorporating or based on someone else's work), then all source works must be freely copyable and distributable under the terms of some [GPL-compatible license](https://www.gnu.org/licenses/license-list.html#GPLCompatibleLicenses) (such as Creative Commonns) and you must clearly give attribution to the copyright holders with a hyperlinks to the original sources.

Contributions that do not meet the above criteria will not be accepted and will probably be deleted.


### Pull Requests

* Developers: please issue pull requests against the [upstream 'development' branch: https://github.com/LiveCodingTVOfficial/community_website](https://github.com/LiveCodingTVOfficial/community_website/tree/development).
* Designers: please issue pull requests against the [upstream 'design' branch: https://github.com/LiveCodingTVOfficial/community_website](https://github.com/LiveCodingTVOfficial/community_website/tree/design).

Note that branches other than 'master' tend to be rebased often so you may need to force pull those.  Please rebase all pull requests on/into the latest development or design HEAD and squash trivial commits but try to retain significant notable commits (see example below).  Ideally in this way, all upstream branches should be a fast-foreward from master and so re-sync should be simple.


### Commit Messages

Please add commit messages of the following form:
```
short general description of feature in declarative tense (optional issue #)
<EMPTY LINE>
  * specific notable change
  * specific notable change
  * specific notable change
  * specific notable change

e.g.

add bar powers to the mighty foo (issue #42)

  * added Bar class
  * added height, width instance vars to Bar class
  * added Bar instance var to Foo class
  * added setBar(), getBar() accessors to Foo class
```


### Issue Tracker

Please do not hesitate to use the issue tracker for bug reports or constructive notes related to that specific issue and significant progress updates that are not yet in a pull request; but use other channels for other issues and lengthy discussions.
