pub const PoolFilterName = enum {
    status,
    message_type,
    two_way_enabled,
    self_managed_opt_outs_enabled,
    opt_out_list_name,
    shared_routes_enabled,
    deletion_protection_enabled,
    two_way_channel_arn,

    pub const json_field_names = .{
        .status = "STATUS",
        .message_type = "MESSAGE_TYPE",
        .two_way_enabled = "TWO_WAY_ENABLED",
        .self_managed_opt_outs_enabled = "SELF_MANAGED_OPT_OUTS_ENABLED",
        .opt_out_list_name = "OPT_OUT_LIST_NAME",
        .shared_routes_enabled = "SHARED_ROUTES_ENABLED",
        .deletion_protection_enabled = "DELETION_PROTECTION_ENABLED",
        .two_way_channel_arn = "TWO_WAY_CHANNEL_ARN",
    };
};
