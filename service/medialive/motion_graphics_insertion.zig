/// Motion Graphics Insertion
pub const MotionGraphicsInsertion = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
