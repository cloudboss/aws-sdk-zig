pub const BrowserSessionStatus = enum {
    ready,
    terminated,

    pub const json_field_names = .{
        .ready = "READY",
        .terminated = "TERMINATED",
    };
};
