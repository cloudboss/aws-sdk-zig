pub const IdentifiedType = enum {
    stateless_rule_forwarding_asymmetrically,
    stateless_rule_contains_tcp_flags,

    pub const json_field_names = .{
        .stateless_rule_forwarding_asymmetrically = "STATELESS_RULE_FORWARDING_ASYMMETRICALLY",
        .stateless_rule_contains_tcp_flags = "STATELESS_RULE_CONTAINS_TCP_FLAGS",
    };
};
