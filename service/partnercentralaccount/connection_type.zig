pub const ConnectionType = enum {
    opportunity_collaboration,
    subsidiary,

    pub const json_field_names = .{
        .opportunity_collaboration = "OPPORTUNITY_COLLABORATION",
        .subsidiary = "SUBSIDIARY",
    };
};
