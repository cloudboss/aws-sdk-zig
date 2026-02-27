const Quality = @import("quality.zig").Quality;
const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;
const Variant = @import("variant.zig").Variant;

/// Contains asset property value information.
pub const AssetPropertyValue = struct {
    /// The quality of the asset property value.
    quality: ?Quality,

    /// The timestamp of the asset property value.
    timestamp: TimeInNanos,

    /// The value of the asset property (see `Variant`).
    value: Variant,

    pub const json_field_names = .{
        .quality = "quality",
        .timestamp = "timestamp",
        .value = "value",
    };
};
