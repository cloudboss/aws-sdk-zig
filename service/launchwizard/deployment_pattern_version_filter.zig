const DeploymentPatternVersionFilterKey = @import("deployment_pattern_version_filter_key.zig").DeploymentPatternVersionFilterKey;

/// A filter for deployment pattern versions. Use this filter to specify
/// criteria for querying deployment pattern versions in Launch Wizard.
pub const DeploymentPatternVersionFilter = struct {
    /// The name of the filter attribute. Specifies which attribute to filter on
    /// when querying deployment pattern versions.
    name: DeploymentPatternVersionFilterKey,

    /// The values to filter by. Contains the specific values to match against when
    /// filtering deployment pattern versions.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
