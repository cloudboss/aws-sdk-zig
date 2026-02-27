/// The catalog data for a repository. This data is publicly visible in the
/// Amazon ECR Public Gallery.
pub const RepositoryCatalogData = struct {
    /// The longform description of the contents of the repository. This text
    /// appears in the
    /// repository details on the Amazon ECR Public Gallery.
    about_text: ?[]const u8,

    /// The architecture tags that are associated with the repository.
    ///
    /// Only supported operating system tags appear publicly in the Amazon ECR
    /// Public Gallery. For
    /// more information, see RepositoryCatalogDataInput.
    architectures: ?[]const []const u8,

    /// The short description of the repository.
    description: ?[]const u8,

    /// The URL that contains the logo that's associated with the repository.
    logo_url: ?[]const u8,

    /// Indicates whether the repository is certified by Amazon Web Services
    /// Marketplace.
    marketplace_certified: ?bool,

    /// The operating system tags that are associated with the repository.
    ///
    /// Only supported operating system tags appear publicly in the Amazon ECR
    /// Public Gallery. For
    /// more information, see RepositoryCatalogDataInput.
    operating_systems: ?[]const []const u8,

    /// The longform usage details of the contents of the repository. The usage text
    /// provides
    /// context for users of the repository.
    usage_text: ?[]const u8,

    pub const json_field_names = .{
        .about_text = "aboutText",
        .architectures = "architectures",
        .description = "description",
        .logo_url = "logoUrl",
        .marketplace_certified = "marketplaceCertified",
        .operating_systems = "operatingSystems",
        .usage_text = "usageText",
    };
};
