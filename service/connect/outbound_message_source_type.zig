pub const OutboundMessageSourceType = enum {
    template,
    raw,

    pub const json_field_names = .{
        .template = "TEMPLATE",
        .raw = "RAW",
    };
};
