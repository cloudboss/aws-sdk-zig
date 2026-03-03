const Range = @import("range.zig").Range;
const Threshold = @import("threshold.zig").Threshold;

/// The conditions including range, object count, and threshold for the
/// calculated
/// attribute.
pub const Conditions = struct {
    /// The number of profile objects used for the calculated attribute.
    object_count: ?i32 = null,

    /// The relative time period over which data is included in the aggregation.
    range: ?Range = null,

    /// The threshold for the calculated attribute.
    threshold: ?Threshold = null,

    pub const json_field_names = .{
        .object_count = "ObjectCount",
        .range = "Range",
        .threshold = "Threshold",
    };
};
