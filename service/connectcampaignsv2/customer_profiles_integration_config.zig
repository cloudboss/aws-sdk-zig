const aws = @import("aws");

/// Customer Profiles integration config
pub const CustomerProfilesIntegrationConfig = struct {
    domain_arn: []const u8,

    object_type_names: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
        .object_type_names = "objectTypeNames",
    };
};
