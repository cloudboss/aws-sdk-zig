const RangeOverride = @import("range_override.zig").RangeOverride;

/// An object to override the original condition block of a calculated
/// attribute.
pub const ConditionOverrides = struct {
    /// The relative time period over which data is included in the aggregation for
    /// this
    /// override.
    range: ?RangeOverride = null,

    pub const json_field_names = .{
        .range = "Range",
    };
};
