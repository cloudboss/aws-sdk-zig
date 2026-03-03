const PackageGroupOriginConfiguration = @import("package_group_origin_configuration.zig").PackageGroupOriginConfiguration;
const PackageGroupReference = @import("package_group_reference.zig").PackageGroupReference;

/// Details about a package group.
pub const PackageGroupSummary = struct {
    /// The ARN of the package group.
    arn: ?[]const u8 = null,

    /// The contact information of the package group.
    contact_info: ?[]const u8 = null,

    /// A timestamp that represents the date and time the repository was created.
    created_time: ?i64 = null,

    /// The description of the package group.
    description: ?[]const u8 = null,

    /// The domain that contains the package group.
    domain_name: ?[]const u8 = null,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// Details about the package origin configuration of a package group.
    origin_configuration: ?PackageGroupOriginConfiguration = null,

    /// The direct parent package group of the package group.
    parent: ?PackageGroupReference = null,

    /// The pattern of the package group. The pattern determines which packages are
    /// associated with the package group.
    pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .contact_info = "contactInfo",
        .created_time = "createdTime",
        .description = "description",
        .domain_name = "domainName",
        .domain_owner = "domainOwner",
        .origin_configuration = "originConfiguration",
        .parent = "parent",
        .pattern = "pattern",
    };
};
