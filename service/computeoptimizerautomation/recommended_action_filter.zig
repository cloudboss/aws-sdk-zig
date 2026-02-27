const RecommendedActionFilterName = @import("recommended_action_filter_name.zig").RecommendedActionFilterName;

/// A filter used to narrow down recommended action results based on specific
/// criteria.
pub const RecommendedActionFilter = struct {
    /// The name of the filter field to apply.
    name: RecommendedActionFilterName,

    /// List of filter values to match against the specified filter name. Used to
    /// narrow down recommended actions based on specific criteria.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
