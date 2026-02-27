pub const SegmentActionServiceInsertion = enum {
    send_via,
    send_to,

    pub const json_field_names = .{
        .send_via = "SEND_VIA",
        .send_to = "SEND_TO",
    };
};
