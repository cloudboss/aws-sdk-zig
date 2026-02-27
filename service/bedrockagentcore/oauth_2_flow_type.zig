pub const Oauth2FlowType = enum {
    user_federation,
    m2_m,

    pub const json_field_names = .{
        .user_federation = "USER_FEDERATION",
        .m2_m = "M2M",
    };
};
