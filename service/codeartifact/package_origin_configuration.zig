const PackageOriginRestrictions = @import("package_origin_restrictions.zig").PackageOriginRestrictions;

/// Details about the package origin configuration of a package.
pub const PackageOriginConfiguration = struct {
    /// A `PackageOriginRestrictions` object that contains information
    /// about the upstream and publish package origin configuration for the package.
    restrictions: ?PackageOriginRestrictions = null,

    pub const json_field_names = .{
        .restrictions = "restrictions",
    };
};
