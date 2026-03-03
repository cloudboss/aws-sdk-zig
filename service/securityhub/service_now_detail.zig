const ConnectorAuthStatus = @import("connector_auth_status.zig").ConnectorAuthStatus;

/// Information about a ServiceNow ITSM integration.
pub const ServiceNowDetail = struct {
    /// The status of the authorization between ServiceNow and the service.
    auth_status: ConnectorAuthStatus,

    /// The instanceName of ServiceNow ITSM.
    instance_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the ServiceNow credentials.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .auth_status = "AuthStatus",
        .instance_name = "InstanceName",
        .secret_arn = "SecretArn",
    };
};
