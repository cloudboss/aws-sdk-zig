const InterpolationType = @import("interpolation_type.zig").InterpolationType;

/// An object that specifies how to interpolate data in a list.
pub const InterpolationParameters = struct {
    /// The interpolation type.
    interpolation_type: ?InterpolationType = null,

    /// The interpolation time interval in seconds.
    interval_in_seconds: ?i64 = null,

    pub const json_field_names = .{
        .interpolation_type = "interpolationType",
        .interval_in_seconds = "intervalInSeconds",
    };
};
