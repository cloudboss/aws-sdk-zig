pub const RuleGroupRequestPhase = enum {
    pre_dns,
    pre_req,
    post_res,

    pub const json_field_names = .{
        .pre_dns = "PRE_DNS",
        .pre_req = "PRE_REQ",
        .post_res = "POST_RES",
    };
};
