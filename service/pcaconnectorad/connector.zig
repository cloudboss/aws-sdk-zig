const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;
const ConnectorStatusReason = @import("connector_status_reason.zig").ConnectorStatusReason;
const VpcInformation = @import("vpc_information.zig").VpcInformation;

/// Amazon Web Services Private CA Connector for Active Directory is a service
/// that links your Active Directory with Amazon Web Services Private CA. The
/// connector brokers the
/// exchange of certificates from Amazon Web Services Private CA to
/// domain-joined users and machines managed with
/// Active Directory.
pub const Connector = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateConnector](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateConnector.html).
    arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the certificate authority being used.
    certificate_authority_arn: ?[]const u8,

    /// Certificate enrollment endpoint for Active Directory domain-joined objects
    /// reach out to when
    /// requesting certificates.
    certificate_enrollment_policy_server_endpoint: ?[]const u8,

    /// The date and time that the connector was created.
    created_at: ?i64,

    /// The identifier of the Active Directory.
    directory_id: ?[]const u8,

    /// Status of the connector. Status can be creating, active, deleting, or
    /// failed.
    status: ?ConnectorStatus,

    /// Additional information about the connector status if the status is failed.
    status_reason: ?ConnectorStatusReason,

    /// The date and time that the connector was updated.
    updated_at: ?i64,

    /// Information of the VPC and security group(s) used with the connector.
    vpc_information: ?VpcInformation,

    pub const json_field_names = .{
        .arn = "Arn",
        .certificate_authority_arn = "CertificateAuthorityArn",
        .certificate_enrollment_policy_server_endpoint = "CertificateEnrollmentPolicyServerEndpoint",
        .created_at = "CreatedAt",
        .directory_id = "DirectoryId",
        .status = "Status",
        .status_reason = "StatusReason",
        .updated_at = "UpdatedAt",
        .vpc_information = "VpcInformation",
    };
};
