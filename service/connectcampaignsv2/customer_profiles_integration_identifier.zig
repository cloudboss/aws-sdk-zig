/// Customer Profiles integration identifier
pub const CustomerProfilesIntegrationIdentifier = struct {
    domain_arn: []const u8,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
    };
};
