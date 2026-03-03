/// Describes a filter used for the target resources in an experiment.
pub const ExperimentTargetFilter = struct {
    /// The attribute path for the filter.
    path: ?[]const u8 = null,

    /// The attribute values for the filter.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .path = "path",
        .values = "values",
    };
};
