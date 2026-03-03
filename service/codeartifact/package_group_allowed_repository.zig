const PackageGroupOriginRestrictionType = @import("package_group_origin_restriction_type.zig").PackageGroupOriginRestrictionType;

/// Details about an allowed repository for a package group, including its name
/// and origin configuration.
pub const PackageGroupAllowedRepository = struct {
    /// The origin configuration restriction type of the allowed repository.
    origin_restriction_type: ?PackageGroupOriginRestrictionType = null,

    /// The name of the allowed repository.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .origin_restriction_type = "originRestrictionType",
        .repository_name = "repositoryName",
    };
};
