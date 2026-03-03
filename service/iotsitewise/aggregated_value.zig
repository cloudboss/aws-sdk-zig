const Quality = @import("quality.zig").Quality;
const Aggregates = @import("aggregates.zig").Aggregates;

/// Contains aggregated asset property values (for example, average, minimum,
/// and
/// maximum).
pub const AggregatedValue = struct {
    /// The quality of the aggregated data.
    quality: ?Quality = null,

    /// The date the aggregating computations occurred, in Unix epoch time.
    timestamp: i64,

    /// The value of the aggregates.
    value: Aggregates,

    pub const json_field_names = .{
        .quality = "quality",
        .timestamp = "timestamp",
        .value = "value",
    };
};
