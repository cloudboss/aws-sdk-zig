pub const LaunchActionParameterType = enum {
    ssm_store,
    dynamic,

    pub const json_field_names = .{
        .ssm_store = "SSM_STORE",
        .dynamic = "DYNAMIC",
    };
};
