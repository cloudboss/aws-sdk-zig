const PackageGroupOriginRestrictionMode = @import("package_group_origin_restriction_mode.zig").PackageGroupOriginRestrictionMode;
const PackageGroupReference = @import("package_group_reference.zig").PackageGroupReference;

/// Contains information about the configured restrictions of the origin
/// controls of a package group.
pub const PackageGroupOriginRestriction = struct {
    /// The effective package group origin restriction setting. If the value of
    /// `mode` is `ALLOW`,
    /// `ALLOW_SPECIFIC_REPOSITORIES`, or `BLOCK`, then the value of `effectiveMode`
    /// is the same. Otherwise, when the value of `mode` is `INHERIT`, then the
    /// value of `effectiveMode` is the value of
    /// `mode` of the first parent group which does not have a value of `INHERIT`.
    effective_mode: ?PackageGroupOriginRestrictionMode = null,

    /// The parent package group that the package group origin restrictions are
    /// inherited from.
    inherited_from: ?PackageGroupReference = null,

    /// The package group origin restriction setting. If the value of `mode` is
    /// `ALLOW`,
    /// `ALLOW_SPECIFIC_REPOSITORIES`, or `BLOCK`, then the value of `effectiveMode`
    /// is the same. Otherwise, when the value is `INHERIT`, then the value of
    /// `effectiveMode` is the value of
    /// `mode` of the first parent group which does not have a value of `INHERIT`.
    mode: ?PackageGroupOriginRestrictionMode = null,

    /// The number of repositories in the allowed repository list.
    repositories_count: ?i64 = null,

    pub const json_field_names = .{
        .effective_mode = "effectiveMode",
        .inherited_from = "inheritedFrom",
        .mode = "mode",
        .repositories_count = "repositoriesCount",
    };
};
