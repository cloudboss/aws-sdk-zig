const aws = @import("aws");

const PackageGroupOriginRestriction = @import("package_group_origin_restriction.zig").PackageGroupOriginRestriction;

/// The package group origin configuration that determines how package versions
/// can enter repositories.
pub const PackageGroupOriginConfiguration = struct {
    /// The origin configuration settings that determine how package versions can
    /// enter repositories.
    restrictions: ?[]const aws.map.MapEntry(PackageGroupOriginRestriction),

    pub const json_field_names = .{
        .restrictions = "restrictions",
    };
};
