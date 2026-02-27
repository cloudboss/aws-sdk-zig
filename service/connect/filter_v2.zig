const FilterV2StringCondition = @import("filter_v2_string_condition.zig").FilterV2StringCondition;

/// Contains the filter to apply when retrieving metrics with the
/// [GetMetricDataV2](https://docs.aws.amazon.com/connect/latest/APIReference/API_GetMetricDataV2.html) API.
pub const FilterV2 = struct {
    /// The key to use for filtering data. For example, `QUEUE`, `ROUTING_PROFILE,
    /// AGENT`,
    /// `CHANNEL`, `AGENT_HIERARCHY_LEVEL_ONE`, `AGENT_HIERARCHY_LEVEL_TWO`,
    /// `AGENT_HIERARCHY_LEVEL_THREE`, `AGENT_HIERARCHY_LEVEL_FOUR`,
    /// `AGENT_HIERARCHY_LEVEL_FIVE`. There must be at least 1 key and a maximum 5
    /// keys.
    filter_key: ?[]const u8,

    /// The identifiers to use for filtering data. For example, if you have a filter
    /// key of `QUEUE`, you
    /// would add queue IDs or ARNs in `FilterValues`.
    filter_values: ?[]const []const u8,

    /// System defined filtering condition. For example, the NOT_EXISTS
    /// StringCondition returns documents where the
    /// field specified by FilterKey does not exist in the document.
    ///
    /// When the NOT_EXISTS StringCondition is added to a FilterV2 object,
    /// FilterValues must be null or empty.
    string_condition: ?FilterV2StringCondition,

    pub const json_field_names = .{
        .filter_key = "FilterKey",
        .filter_values = "FilterValues",
        .string_condition = "StringCondition",
    };
};
