pub const AccessDeniedExceptionReason = enum {
    access_denied,
    incompatible_benefit_aws_partner_state,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .incompatible_benefit_aws_partner_state = "INCOMPATIBLE_BENEFIT_AWS_PARTNER_STATE",
    };
};
