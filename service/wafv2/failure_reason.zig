pub const FailureReason = enum {
    token_missing,
    token_expired,
    token_invalid,
    token_domain_mismatch,

    pub const json_field_names = .{
        .token_missing = "TOKEN_MISSING",
        .token_expired = "TOKEN_EXPIRED",
        .token_invalid = "TOKEN_INVALID",
        .token_domain_mismatch = "TOKEN_DOMAIN_MISMATCH",
    };
};
