const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// The input structure for specifying Platform.
/// Platform refers to the unique name of the specific platform the
/// instrument is attached to. For satellites it is the name of the satellite,
/// eg. landsat-8 (Landsat-8), sentinel-2a.
pub const PlatformInput = struct {
    /// The ComparisonOperator to use with PlatformInput.
    comparison_operator: ?ComparisonOperator = null,

    /// The value of the platform.
    value: []const u8,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .value = "Value",
    };
};
