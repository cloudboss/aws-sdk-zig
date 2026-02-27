pub const SubscriptionStatus = enum {
    opt_in,
    opt_out,

    pub const json_field_names = .{
        .opt_in = "OPT_IN",
        .opt_out = "OPT_OUT",
    };
};
