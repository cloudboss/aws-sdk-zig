/// Event trigger of the campaign
pub const EventTrigger = struct {
    customer_profiles_domain_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_profiles_domain_arn = "customerProfilesDomainArn",
    };
};
