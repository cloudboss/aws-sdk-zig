/// Indicates the direction the eyes are gazing in (independent of the head
/// pose) as
/// determined by its pitch and yaw.
pub const EyeDirection = struct {
    /// The confidence that the service has in its predicted eye direction.
    confidence: ?f32 = null,

    /// Value representing eye direction on the pitch axis.
    pitch: ?f32 = null,

    /// Value representing eye direction on the yaw axis.
    yaw: ?f32 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .pitch = "Pitch",
        .yaw = "Yaw",
    };
};
