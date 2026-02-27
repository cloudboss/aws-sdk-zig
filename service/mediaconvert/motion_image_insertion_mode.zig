/// Choose the type of motion graphic asset that you are providing for your
/// overlay. You can choose either a .mov file or a series of .png files.
pub const MotionImageInsertionMode = enum {
    mov,
    png,

    pub const json_field_names = .{
        .mov = "MOV",
        .png = "PNG",
    };
};
