pub const RuleIpOperator = enum {
    cidr_matches,
    not_cidr_matches,

    pub const json_field_names = .{
        .cidr_matches = "CIDR_MATCHES",
        .not_cidr_matches = "NOT_CIDR_MATCHES",
    };
};
