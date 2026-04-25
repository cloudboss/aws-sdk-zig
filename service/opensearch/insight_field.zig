const InsightFieldType = @import("insight_field_type.zig").InsightFieldType;

/// Represents a field in the detailed view of an insight, returned by the
/// `DescribeInsightDetails` operation.
pub const InsightField = struct {
    /// The name of the insight field.
    name: []const u8,

    /// The type of the insight field. Possible values are `text` and
    /// `metric`.
    @"type": InsightFieldType,

    /// The value of the insight field.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
        .value = "Value",
    };
};
