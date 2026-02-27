pub const OpportunityOrigin = enum {
    aws_referral,
    partner_referral,

    pub const json_field_names = .{
        .aws_referral = "AWS_REFERRAL",
        .partner_referral = "PARTNER_REFERRAL",
    };
};
