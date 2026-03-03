/// Represents metadata about a patch.
pub const Patch = struct {
    /// The Advisory ID of the patch. For example, `RHSA-2020:3779`. Applies to
    /// Linux-based managed nodes only.
    advisory_ids: ?[]const []const u8 = null,

    /// The architecture of the patch. For example, in
    /// `example-pkg-0.710.10-2.7.abcd.x86_64`, the architecture is indicated by
    /// `x86_64`. Applies to Linux-based managed nodes only.
    arch: ?[]const u8 = null,

    /// The Bugzilla ID of the patch. For example, `1600646`. Applies to Linux-based
    /// managed nodes only.
    bugzilla_ids: ?[]const []const u8 = null,

    /// The classification of the patch. For example, `SecurityUpdates`,
    /// `Updates`, or `CriticalUpdates`.
    classification: ?[]const u8 = null,

    /// The URL where more information can be obtained about the patch.
    content_url: ?[]const u8 = null,

    /// The Common Vulnerabilities and Exposures (CVE) ID of the patch. For example,
    /// `CVE-2011-3192`. Applies to Linux-based managed nodes only.
    cve_ids: ?[]const []const u8 = null,

    /// The description of the patch.
    description: ?[]const u8 = null,

    /// The epoch of the patch. For example in
    /// `pkg-example-EE-20180914-2.2.amzn1.noarch`, the epoch value is
    /// `20180914-2`. Applies to Linux-based managed nodes only.
    epoch: i32 = 0,

    /// The ID of the patch. Applies to Windows patches only.
    ///
    /// This ID isn't the same as the Microsoft Knowledge Base ID.
    id: ?[]const u8 = null,

    /// The Microsoft Knowledge Base ID of the patch. Applies to Windows patches
    /// only.
    kb_number: ?[]const u8 = null,

    /// The language of the patch if it's language-specific.
    language: ?[]const u8 = null,

    /// The ID of the Microsoft Security Response Center (MSRC) bulletin the patch
    /// is related to.
    /// For example, `MS14-045`. Applies to Windows patches only.
    msrc_number: ?[]const u8 = null,

    /// The severity of the patch, such as `Critical`, `Important`, or
    /// `Moderate`. Applies to Windows patches only.
    msrc_severity: ?[]const u8 = null,

    /// The name of the patch. Applies to Linux-based managed nodes only.
    name: ?[]const u8 = null,

    /// The specific product the patch is applicable for. For example,
    /// `WindowsServer2016` or `AmazonLinux2018.03`.
    product: ?[]const u8 = null,

    /// The product family the patch is applicable for. For example, `Windows` or
    /// `Amazon Linux 2`.
    product_family: ?[]const u8 = null,

    /// The particular release of a patch. For example, in
    /// `pkg-example-EE-20180914-2.2.amzn1.noarch`, the release is `2.amaz1`.
    /// Applies to Linux-based managed nodes only.
    release: ?[]const u8 = null,

    /// The date the patch was released.
    release_date: ?i64 = null,

    /// The source patch repository for the operating system and version, such as
    /// `trusty-security` for Ubuntu Server 14.04 LTE and `focal-security` for
    /// Ubuntu Server 20.04 LTE. Applies to Linux-based managed nodes only.
    repository: ?[]const u8 = null,

    /// The severity level of the patch. For example, `CRITICAL` or
    /// `MODERATE`.
    severity: ?[]const u8 = null,

    /// The title of the patch.
    title: ?[]const u8 = null,

    /// The name of the vendor providing the patch.
    vendor: ?[]const u8 = null,

    /// The version number of the patch. For example, in
    /// `example-pkg-1.710.10-2.7.abcd.x86_64`, the version number is indicated by
    /// `-1`. Applies to Linux-based managed nodes only.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .advisory_ids = "AdvisoryIds",
        .arch = "Arch",
        .bugzilla_ids = "BugzillaIds",
        .classification = "Classification",
        .content_url = "ContentUrl",
        .cve_ids = "CVEIds",
        .description = "Description",
        .epoch = "Epoch",
        .id = "Id",
        .kb_number = "KbNumber",
        .language = "Language",
        .msrc_number = "MsrcNumber",
        .msrc_severity = "MsrcSeverity",
        .name = "Name",
        .product = "Product",
        .product_family = "ProductFamily",
        .release = "Release",
        .release_date = "ReleaseDate",
        .repository = "Repository",
        .severity = "Severity",
        .title = "Title",
        .vendor = "Vendor",
        .version = "Version",
    };
};
