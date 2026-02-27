pub const AgreementStatus = enum {
    active,
    archived,
    cancelled,
    expired,
    renewed,
    replaced,
    rolled_back,
    superseded,
    terminated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .archived = "ARCHIVED",
        .cancelled = "CANCELLED",
        .expired = "EXPIRED",
        .renewed = "RENEWED",
        .replaced = "REPLACED",
        .rolled_back = "ROLLED_BACK",
        .superseded = "SUPERSEDED",
        .terminated = "TERMINATED",
    };
};
