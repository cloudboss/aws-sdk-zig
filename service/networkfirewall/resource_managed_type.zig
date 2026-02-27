pub const ResourceManagedType = enum {
    aws_managed_threat_signatures,
    aws_managed_domain_lists,
    active_threat_defense,
    partner_managed,

    pub const json_field_names = .{
        .aws_managed_threat_signatures = "AWS_MANAGED_THREAT_SIGNATURES",
        .aws_managed_domain_lists = "AWS_MANAGED_DOMAIN_LISTS",
        .active_threat_defense = "ACTIVE_THREAT_DEFENSE",
        .partner_managed = "PARTNER_MANAGED",
    };
};
