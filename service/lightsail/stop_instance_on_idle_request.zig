/// Describes a request to create or edit the `StopInstanceOnIdle` add-on.
///
/// This add-on only applies to Lightsail for Research resources.
pub const StopInstanceOnIdleRequest = struct {
    /// The amount of idle time in minutes after which your virtual computer will
    /// automatically
    /// stop.
    duration: ?[]const u8,

    /// The value to compare with the duration.
    threshold: ?[]const u8,

    pub const json_field_names = .{
        .duration = "duration",
        .threshold = "threshold",
    };
};
