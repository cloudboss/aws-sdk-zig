/// The FPorts for the position information.
pub const Positioning = struct {
    clock_sync: ?i32 = null,

    gnss: ?i32 = null,

    stream: ?i32 = null,

    pub const json_field_names = .{
        .clock_sync = "ClockSync",
        .gnss = "Gnss",
        .stream = "Stream",
    };
};
