/// Indicates the pose of the face as determined by its pitch, roll, and yaw.
pub const Pose = struct {
    /// Value representing the face rotation on the pitch axis.
    pitch: ?f32,

    /// Value representing the face rotation on the roll axis.
    roll: ?f32,

    /// Value representing the face rotation on the yaw axis.
    yaw: ?f32,

    pub const json_field_names = .{
        .pitch = "Pitch",
        .roll = "Roll",
        .yaw = "Yaw",
    };
};
