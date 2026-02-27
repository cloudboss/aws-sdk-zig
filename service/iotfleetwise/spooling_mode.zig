pub const SpoolingMode = enum {
    off,
    to_disk,

    pub const json_field_names = .{
        .off = "OFF",
        .to_disk = "TO_DISK",
    };
};
