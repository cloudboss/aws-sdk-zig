pub const ApplyTimeOf = enum {
    utc,
    device,

    pub const json_field_names = .{
        .utc = "UTC",
        .device = "DEVICE",
    };
};
