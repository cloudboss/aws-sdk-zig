pub const MessageType = enum {
    raw,
    digest,
    external_mu,

    pub const json_field_names = .{
        .raw = "RAW",
        .digest = "DIGEST",
        .external_mu = "EXTERNAL_MU",
    };
};
