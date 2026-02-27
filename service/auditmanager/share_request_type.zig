pub const ShareRequestType = enum {
    sent,
    received,

    pub const json_field_names = .{
        .sent = "SENT",
        .received = "RECEIVED",
    };
};
