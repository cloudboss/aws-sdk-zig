/// Information about the patches to use to update the managed nodes, including
/// target operating
/// systems and source repository. Applies to Linux managed nodes only.
pub const PatchSource = struct {
    /// The value of the repo configuration.
    ///
    /// **Example for yum repositories**
    ///
    /// `[main]`
    ///
    /// `name=MyCustomRepository`
    ///
    /// `baseurl=https://my-custom-repository`
    ///
    /// `enabled=1`
    ///
    /// For information about other options available for your yum repository
    /// configuration, see
    /// [dnf.conf(5)](https://man7.org/linux/man-pages/man5/dnf.conf.5.html) on the
    /// *man7.org* website.
    ///
    /// **Examples for Ubuntu Server and Debian Server**
    ///
    /// `deb http://security.ubuntu.com/ubuntu jammy main`
    ///
    /// `deb https://site.example.com/debian distribution component1 component2
    /// component3`
    ///
    /// Repo information for Ubuntu Server repositories must be specifed in a single
    /// line. For more
    /// examples and information, see [jammy (5)
    /// sources.list.5.gz](https://manpages.ubuntu.com/manpages/jammy/man5/sources.list.5.html) on the *Ubuntu Server Manuals* website and [sources.list format](https://wiki.debian.org/SourcesList#sources.list_format) on the
    /// *Debian Wiki*.
    configuration: []const u8,

    /// The name specified to identify the patch source.
    name: []const u8,

    /// The specific operating system versions a patch repository applies to, such
    /// as "Ubuntu16.04",
    /// "AmazonLinux2016.09", "RedhatEnterpriseLinux7.2" or "Suse12.7". For lists of
    /// supported product
    /// values, see PatchFilter.
    products: []const []const u8,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .name = "Name",
        .products = "Products",
    };
};
