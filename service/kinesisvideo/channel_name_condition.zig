const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// An optional input parameter for the `ListSignalingChannels` API. When this
/// parameter is specified while invoking `ListSignalingChannels`, the API
/// returns only the channels that satisfy a condition specified in
/// `ChannelNameCondition`.
pub const ChannelNameCondition = struct {
    /// A comparison operator. Currently, you can only specify the `BEGINS_WITH`
    /// operator, which finds signaling channels whose names begin with a given
    /// prefix.
    comparison_operator: ?ComparisonOperator,

    /// A value to compare.
    comparison_value: ?[]const u8,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .comparison_value = "ComparisonValue",
    };
};
