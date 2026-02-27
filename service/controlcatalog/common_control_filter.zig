const ObjectiveResourceFilter = @import("objective_resource_filter.zig").ObjectiveResourceFilter;

/// An optional filter that narrows the results to a specific objective.
pub const CommonControlFilter = struct {
    /// The objective that's used as filter criteria.
    ///
    /// You can use this parameter to specify one objective ARN at a time. Passing
    /// multiple ARNs in the `CommonControlFilter` isn’t supported.
    objectives: ?[]const ObjectiveResourceFilter,

    pub const json_field_names = .{
        .objectives = "Objectives",
    };
};
