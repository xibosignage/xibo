The heart of the Xibo platform is open source software and always will be. If you benefit from Xibo and want to
contribute to our project, you're very welcome to do so. There are lots of different ways to be helpful
no matter what you're technical knowledge.

## Be active in the community
It sounds like a simple thing, but one of the most helpful things an experienced user of Xibo can do is to be active
in the [community](https://community.xibo.org.uk). Xibo is lucky enough to attract a huge variety of different users
with different abilities, and the community is always busy with questions and requests for advice. Why not checkout
our [hall of fame](https://community.xibo.org.uk/c/xibo-hall-of-fame/47), and then tell us how
[you use Xibo](https://community.xibo.org.uk/c/user-stories-and-project-showcase/32).

### Report bugs
If you are sure something doesn't work the way it should, or the way it's documented to work, then opening a topic 
in the [Get Help](https://community.xibo.org.uk/c/support/6) section of the Community forum with step-by-step
instructions for reproducing the issue, is super helpful. One of our support team can pick that up and pass it
directly to the development team to be fixed in the next release.

### Suggest a feature or improvement
Xibo thrives on suggestions - much of the software does what it does because of our users describing how they want
Xibo to work. If you have an idea for a new feature, or an improvement to something existing, open a topic
in the [Feature Requests](https://community.xibo.org.uk/c/features/8) category of the Community forum.

A member of the support team will likely want to discuss that with you and find out a bit more (there is nothing worse
than adding a feature which turns out to be not quite what you meant!), but once it's all understood they will pass 
it to the development team to be introduced in an appropriate release.

## Write some code
If you're more technical and fancy getting involved in some software development, then that is great!

### Integrate or extend
Xibo has extensive options for integration and extension, whether that be using the API to connect with 3rd parties,
making exciting new widgets, or extending the software with custom code. Find out more in our
[developer documentation](https://xibo.org.uk/docs/developer/).

### Contribute to the core code
There are a few things you should know before you dive in - but the main thing is to make sure what you want to do is
something we can include, and when we can include it.

There are 3 main applications which we need help with - these are (all links go to the GitHub repository for that application):

- [Content Management System](https://github.com/xibosignage/xibo-cms) ([issues](https://github.com/xibosignage/xibo/issues))
- [Windows Player](https://github.com/xibosignage/xibo-dotnetclient)
- [Linux Player](https://github.com/xibosignage/xibo-linux)

All development is on GitHub in the [xibosignage](https://github.com/xibosignage) organization. Xibo contains multiple
components which are organised into their own repositories, we also have a central repository for collecting issues.
This can be found [here](https://github.com/xibosignage/xibo).

We'd love to work with you and accept your contributions. For small changes like bug fixes, typos, etc. Please fork us
and submit a pull request with the details of what you have changed.

For larger changes, please make sure you are happy to electronically sign a Contributor Licence Agreement
before starting.

#### Fixing a Bug
1. If the bug doesn't already exist in GitHub, open a Topic in the [Get Help](https://community.xibo.org.uk/c/support/6) section of the Community forum.
2. Discuss with a member of the `staff` group to confirm the bug
3. Once the bug is clearly understood the staff member will open a GitHub Issue tagged as a bug. They will target the issue to a release milestone.
4. Fork the appropriate component(s), branch either `develop` (next release) or `master` (next bug fix release)
5. Implement the work, referencing the issue in your commit (`xibosignage/xibo#XXX`)
6. Create a Pull Request into either the `develop` or `master` branch as appropriate
7. Discuss, adjust and merge

#### Implementing a Feature
1. If the feature doesn't already exist in GitHub, open a Topic in the [Feature Requests](https://community.xibo.org.uk/c/features/8) category of the Community forum.
2. Discuss with a member of the `staff` group to confirm the feature and provide direction on how to implement it
3. The staff member will open a GitHub Issue tagged as an enhancement. They will target the issue to the next development release milestone.
4. Fork the appropriate component(s), branch `develop` (next release)
5. Implement the work, referencing the issue in your commit (`xibosignage/xibo#XXX`)
6. Create a Pull Request into `develop`
7. Discuss, adjust and merge

#### Release Cycle
Xibo actively works on two releases at any one time - the stable release and the development release. The stable
release is in the `master` branch, and the development release is in the `develop` branch. It is always best to ask
the best place to put your code before you start, as sometimes there can be framework changes between major releases.

#### Contributor Licence Agreement (CLA)
So that we can be confident in the future of the project, any significant contribution requires a CLA (contributor
licence agreement) to be reviewed and signed [here](https://github.com/xibosignage/xibo/blob/master/CONTRIBUTING.md).

Signing the CLA is easy and hopefully painless.

1. Read the [CLA](cla-1.0.md).
2. Make an account on [GitHub](https://github.com/) if you don't have one already.
3. File a pull request for this project.
4. Email us.
5. Wait for us to merge your pull request.

**Filing the Pull Request**

GitHub has [documentation to help you](https://help.github.com/articles/using-pull-requests) file a pull request.

Your pull request should be the addition of a single file to the `contributors` folder. The name of the file should
be your GitHub userid, with `.md` appended to the end. For example, the user `dasgarner` would create the
file `dasgarner.md` in the `contributors` folder - this would result in the following full
path: `contribitors/dasgarner.md`.

The file must contain the following:

```
[date]

I hereby agree to the terms of the Contributors License
Agreement, version 1.0, with MD5 checksum
e0de59b14f4c8a5d54ae9e75b182bd95.

I furthermore declare that I am authorized and able to make this
agreement and sign this declaration.

Signed,

[your name]
https://github.com/[your github userid]
```

Replace the bracketed text as follows:

* [date] with today's date, in the unambiguous numeric form YYYY-MM-DD.
* [your name] with your name.
* [your github userid] with your GitHub userid.

You can confirm the MD5 checksum of the CLA by running the md5 program over `cla-1.0.md`:

```
md5sum cla-1.0.md
MD5 (cla-1.0.md) = e0de59b14f4c8a5d54ae9e75b182bd95
```

If the output is different from above, do not sign the CLA and let us know.

**Sending the Email**

Email us at [info@xibo.org.uk](mailto:info@xibo.org.uk), with the subject "CLA" and the following body:

```
I submitted a pull request to indicate agreement to the terms
of the Contributors License Agreement.

Signed,

[your name]
https://github.com/[your github userid]
[your address]
[your phone number]
```

Replace the bracketed text as follows:

* `[your name]` with your name.
* `[your github userid]` with your GitHub userid.
* `[your address]` with a physical mailing address at which you can be
  contacted.
* `[your phone number]` with a phone number at which you can be contacted.


## You've refused my contribution!
We are always very sorry when your idea or contribution doesn't fit with the project. There are lots of things we
have to take into consideration before including something. Xibo has a lot of existing users we need to consider.
We don't want to be strict gatekeepers, but we have a duty to our existing users to make sure that changes to the 
software make sense.

Don't worry though, you can still have your feature in your Xibo! We have built Xibo with an extensive set of tools
to extend with custom additions and modifications. Xibo also has a comprehensive API.

Find out more in our [developer documentation](https://xibo.org.uk/docs/developer/).
