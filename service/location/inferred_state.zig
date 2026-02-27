const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;

/// The inferred state of the device, given the provided position, IP address,
/// cellular signals, and Wi-Fi- access points.
pub const InferredState = struct {
    /// The level of certainty of the inferred position.
    accuracy: ?PositionalAccuracy,

    /// The distance between the inferred position and the device's self-reported
    /// position.
    deviation_distance: ?f64,

    /// The device position inferred by the provided position, IP address, cellular
    /// signals, and Wi-Fi- access points.
    position: ?[]const f64,

    /// Indicates if a proxy was used.
    proxy_detected: bool,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .deviation_distance = "DeviationDistance",
        .position = "Position",
        .proxy_detected = "ProxyDetected",
    };
};
