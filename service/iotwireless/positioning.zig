/// The FPorts for the position information.
pub const Positioning = struct {
    clock_sync: ?i32,

    gnss: ?i32,

    stream: ?i32,

    pub const json_field_names = .{
        .clock_sync = "ClockSync",
        .gnss = "Gnss",
        .stream = "Stream",
    };
};
