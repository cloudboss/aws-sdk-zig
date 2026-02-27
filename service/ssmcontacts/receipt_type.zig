pub const ReceiptType = enum {
    delivered,
    @"error",
    read,
    sent,
    stop,

    pub const json_field_names = .{
        .delivered = "DELIVERED",
        .@"error" = "ERROR",
        .read = "READ",
        .sent = "SENT",
        .stop = "STOP",
    };
};
