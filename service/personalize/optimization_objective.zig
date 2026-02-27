const ObjectiveSensitivity = @import("objective_sensitivity.zig").ObjectiveSensitivity;

/// Describes the additional objective for the solution, such as maximizing
/// streaming
/// minutes or increasing revenue. For more information see [Optimizing a
/// solution](https://docs.aws.amazon.com/personalize/latest/dg/optimizing-solution-for-objective.html).
pub const OptimizationObjective = struct {
    /// The numerical metadata column in an Items dataset related to the
    /// optimization objective. For example, VIDEO_LENGTH (to maximize streaming
    /// minutes), or PRICE (to maximize revenue).
    item_attribute: ?[]const u8,

    /// Specifies how Amazon Personalize balances the importance of your
    /// optimization objective versus relevance.
    objective_sensitivity: ?ObjectiveSensitivity,

    pub const json_field_names = .{
        .item_attribute = "itemAttribute",
        .objective_sensitivity = "objectiveSensitivity",
    };
};
