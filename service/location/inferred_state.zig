const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;

/// The inferred state of the device, given the provided position, IP address,
/// cellular signals, and Wi-Fi- access points.
pub const InferredState = struct {
    /// The level of certainty of the inferred position.
    accuracy: ?PositionalAccuracy = null,

    /// The distance between the inferred position and the device's self-reported
    /// position.
    deviation_distance: ?f64 = null,

    /// The device position inferred by the provided position, IP address, cellular
    /// signals, and Wi-Fi- access points.
    position: ?[]const f64 = null,

    /// Indicates if a proxy was used.
    proxy_detected: bool,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .deviation_distance = "DeviationDistance",
        .position = "Position",
        .proxy_detected = "ProxyDetected",
    };
};
