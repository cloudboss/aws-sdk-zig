/// Defines the level of certainty of the position.
pub const PositionalAccuracy = struct {
    /// Estimated maximum distance, in meters, between the measured position and the
    /// true position of a device, along the Earth's surface.
    horizontal: f64,

    pub const json_field_names = .{
        .horizontal = "Horizontal",
    };
};
