/// A structure that contains identifying information for a service entity.
pub const ServiceEntity = struct {
    /// The Amazon Web Services account ID where the service is located. Provide
    /// this value only for cross-account access.
    aws_account_id: ?[]const u8,

    /// The environment where the service is deployed.
    environment: ?[]const u8,

    /// The name of the service.
    name: ?[]const u8,

    /// The type of the service entity.
    type: ?[]const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .environment = "Environment",
        .name = "Name",
        .type = "Type",
    };
};
