const CustomDNSServer = @import("custom_dns_server.zig").CustomDNSServer;
const dnsStatus = @import("dns_status.zig").dnsStatus;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const tgwStatus = @import("tgw_status.zig").tgwStatus;
const TransitGatewayConfiguration = @import("transit_gateway_configuration.zig").TransitGatewayConfiguration;

/// The details of a kdb environment.
pub const KxEnvironment = struct {
    /// The identifier of the availability zones where subnets for the environment
    /// are created.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The unique identifier of the AWS account in which you create the kdb
    /// environment.
    aws_account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the certificate authority:
    certificate_authority_arn: ?[]const u8 = null,

    /// The timestamp at which the kdb environment was created in FinSpace. The
    /// value is determined as epoch time in milliseconds. For example, the value
    /// for Monday, November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    creation_timestamp: ?i64 = null,

    /// A list of DNS server name and server IP. This is used to set up Route-53
    /// outbound resolvers.
    custom_dns_configuration: ?[]const CustomDNSServer = null,

    /// A unique identifier for the AWS environment infrastructure account.
    dedicated_service_account_id: ?[]const u8 = null,

    /// A description of the kdb environment.
    description: ?[]const u8 = null,

    /// The status of DNS configuration.
    dns_status: ?dnsStatus = null,

    /// The Amazon Resource Name (ARN) of your kdb environment.
    environment_arn: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// Specifies the error message that appears if a flow fails.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The name of the kdb environment.
    name: ?[]const u8 = null,

    /// The status of the environment creation.
    ///
    /// * CREATE_REQUESTED – Environment creation has been requested.
    ///
    /// * CREATING – Environment is in the process of being created.
    ///
    /// * FAILED_CREATION – Environment creation has failed.
    ///
    /// * CREATED – Environment is successfully created and is currently active.
    ///
    /// * DELETE REQUESTED – Environment deletion has been requested.
    ///
    /// * DELETING – Environment is in the process of being deleted.
    ///
    /// * RETRY_DELETION – Initial environment deletion failed, system is
    ///   reattempting delete.
    ///
    /// * DELETED – Environment has been deleted.
    ///
    /// * FAILED_DELETION – Environment deletion has failed.
    status: ?EnvironmentStatus = null,

    /// The status of the network configuration.
    tgw_status: ?tgwStatus = null,

    /// Specifies the transit gateway and network configuration to connect the kdb
    /// environment to an internal network.
    transit_gateway_configuration: ?TransitGatewayConfiguration = null,

    /// The timestamp at which the kdb environment was modified in FinSpace. The
    /// value is determined as epoch time in milliseconds. For example, the value
    /// for Monday, November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    update_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .aws_account_id = "awsAccountId",
        .certificate_authority_arn = "certificateAuthorityArn",
        .creation_timestamp = "creationTimestamp",
        .custom_dns_configuration = "customDNSConfiguration",
        .dedicated_service_account_id = "dedicatedServiceAccountId",
        .description = "description",
        .dns_status = "dnsStatus",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .error_message = "errorMessage",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .status = "status",
        .tgw_status = "tgwStatus",
        .transit_gateway_configuration = "transitGatewayConfiguration",
        .update_timestamp = "updateTimestamp",
    };
};
