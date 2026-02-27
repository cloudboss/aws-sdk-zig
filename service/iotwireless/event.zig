/// Sidewalk device status notification.
pub const Event = enum {
    discovered,
    lost,
    ack,
    nack,
    passthrough,

    pub const json_field_names = .{
        .discovered = "DISCOVERED",
        .lost = "LOST",
        .ack = "ACK",
        .nack = "NACK",
        .passthrough = "PASSTHROUGH",
    };
};
