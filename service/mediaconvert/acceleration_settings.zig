const AccelerationMode = @import("acceleration_mode.zig").AccelerationMode;

/// Accelerated transcoding can significantly speed up jobs with long, visually
/// complex content.
pub const AccelerationSettings = struct {
    /// Specify the conditions when the service will run your job with accelerated
    /// transcoding.
    mode: AccelerationMode,

    pub const json_field_names = .{
        .mode = "Mode",
    };
};
