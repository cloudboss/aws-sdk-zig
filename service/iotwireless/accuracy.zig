/// The accuracy of the estimated position in meters. An empty value indicates
/// that no
/// position data is available. A value of ‘0.0’ value indicates that position
/// data is
/// available. This data corresponds to the position information that you
/// specified instead
/// of the position computed by solver.
pub const Accuracy = struct {
    /// The horizontal accuracy of the estimated position, which is the difference
    /// between the
    /// estimated location and the actual device location.
    horizontal_accuracy: ?f32 = null,

    /// The vertical accuracy of the estimated position, which is the difference
    /// between the
    /// estimated altitude and actual device latitude in meters.
    vertical_accuracy: ?f32 = null,

    pub const json_field_names = .{
        .horizontal_accuracy = "HorizontalAccuracy",
        .vertical_accuracy = "VerticalAccuracy",
    };
};
