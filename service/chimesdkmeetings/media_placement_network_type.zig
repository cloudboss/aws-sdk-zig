pub const MediaPlacementNetworkType = enum {
    ipv4_only,
    dual_stack,

    pub const json_field_names = .{
        .ipv4_only = "IPV4_ONLY",
        .dual_stack = "DUAL_STACK",
    };
};
