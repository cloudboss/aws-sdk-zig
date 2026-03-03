/// An object that contains the catalog data for a repository. This data is
/// publicly visible
/// in the Amazon ECR Public Gallery.
pub const RepositoryCatalogDataInput = struct {
    /// A detailed description of the contents of the repository. It's publicly
    /// visible in the
    /// Amazon ECR Public Gallery. The text must be in markdown format.
    about_text: ?[]const u8 = null,

    /// The system architecture that the images in the repository are compatible
    /// with. On the
    /// Amazon ECR Public Gallery, the following supported architectures appear as
    /// badges on the
    /// repository and are used as search filters.
    ///
    /// If an unsupported tag is added to your repository catalog data, it's
    /// associated with
    /// the repository and can be retrieved using the API but isn't discoverable in
    /// the
    /// Amazon ECR Public Gallery.
    ///
    /// * `ARM`
    ///
    /// * `ARM 64`
    ///
    /// * `x86`
    ///
    /// * `x86-64`
    architectures: ?[]const []const u8 = null,

    /// A short description of the contents of the repository. This text appears in
    /// both the
    /// image details and also when searching for repositories on the Amazon ECR
    /// Public Gallery.
    description: ?[]const u8 = null,

    /// The base64-encoded repository logo payload.
    ///
    /// The repository logo is only publicly visible in the Amazon ECR Public
    /// Gallery for verified
    /// accounts.
    logo_image_blob: ?[]const u8 = null,

    /// The operating systems that the images in the repository are compatible with.
    /// On the
    /// Amazon ECR Public Gallery, the following supported operating systems appear
    /// as badges on the
    /// repository and are used as search filters.
    ///
    /// If an unsupported tag is added to your repository catalog data, it's
    /// associated with
    /// the repository and can be retrieved using the API but isn't discoverable in
    /// the
    /// Amazon ECR Public Gallery.
    ///
    /// * `Linux`
    ///
    /// * `Windows`
    operating_systems: ?[]const []const u8 = null,

    /// Detailed information about how to use the contents of the repository. It's
    /// publicly
    /// visible in the Amazon ECR Public Gallery. The usage text provides context,
    /// support information,
    /// and additional usage details for users of the repository. The text must be
    /// in markdown
    /// format.
    usage_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .about_text = "aboutText",
        .architectures = "architectures",
        .description = "description",
        .logo_image_blob = "logoImageBlob",
        .operating_systems = "operatingSystems",
        .usage_text = "usageText",
    };
};
