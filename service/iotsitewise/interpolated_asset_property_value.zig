const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;
const Variant = @import("variant.zig").Variant;

/// Contains information about an interpolated asset property value.
pub const InterpolatedAssetPropertyValue = struct {
    timestamp: TimeInNanos,

    value: Variant,

    pub const json_field_names = .{
        .timestamp = "timestamp",
        .value = "value",
    };
};
