const ServicePrincipalNameStatus = @import("service_principal_name_status.zig").ServicePrincipalNameStatus;
const ServicePrincipalNameStatusReason = @import("service_principal_name_status_reason.zig").ServicePrincipalNameStatusReason;

/// The service principal name that the connector uses to authenticate with
/// Active Directory.
pub const ServicePrincipalName = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateConnector.html](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateConnector.html).
    connector_arn: ?[]const u8 = null,

    /// The date and time that the service principal name was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateDirectoryRegistration](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateDirectoryRegistration.html).
    directory_registration_arn: ?[]const u8 = null,

    /// The status of a service principal name.
    status: ?ServicePrincipalNameStatus = null,

    /// Additional information for the status of a service principal name if the
    /// status is
    /// failed.
    status_reason: ?ServicePrincipalNameStatusReason = null,

    /// The date and time that the service principal name was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .created_at = "CreatedAt",
        .directory_registration_arn = "DirectoryRegistrationArn",
        .status = "Status",
        .status_reason = "StatusReason",
        .updated_at = "UpdatedAt",
    };
};
