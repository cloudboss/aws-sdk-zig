/// Details about the speed limit corresponding to the span.
///
/// **Unit**: `KilometersPerHour`
pub const RouteSpanSpeedLimitDetails = struct {
    /// Maximum speed.
    ///
    /// **Unit**: `KilometersPerHour`
    max_speed: f64 = 0,

    /// If the span doesn't have a speed limit like the Autobahn.
    unlimited: ?bool = null,

    pub const json_field_names = .{
        .max_speed = "MaxSpeed",
        .unlimited = "Unlimited",
    };
};
