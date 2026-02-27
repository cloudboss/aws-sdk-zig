pub const SendViaMode = enum {
    dual_hop,
    single_hop,

    pub const json_field_names = .{
        .dual_hop = "DUAL_HOP",
        .single_hop = "SINGLE_HOP",
    };
};
