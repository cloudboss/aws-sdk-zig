/// Specify whether your motion graphic overlay repeats on a loop or plays only
/// once.
pub const MotionImagePlayback = enum {
    once,
    repeat,

    pub const json_field_names = .{
        .once = "ONCE",
        .repeat = "REPEAT",
    };
};
