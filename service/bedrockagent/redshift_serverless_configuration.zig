const RedshiftServerlessAuthConfiguration = @import("redshift_serverless_auth_configuration.zig").RedshiftServerlessAuthConfiguration;

/// Contains configurations for authentication to Amazon Redshift Serverless.
pub const RedshiftServerlessConfiguration = struct {
    /// Specifies configurations for authentication to an Amazon Redshift
    /// provisioned data warehouse.
    auth_configuration: RedshiftServerlessAuthConfiguration,

    /// The ARN of the Amazon Redshift workgroup.
    workgroup_arn: []const u8,

    pub const json_field_names = .{
        .auth_configuration = "authConfiguration",
        .workgroup_arn = "workgroupArn",
    };
};
