const IngressVpcConfiguration = @import("ingress_vpc_configuration.zig").IngressVpcConfiguration;
const VpcIngressConnectionStatus = @import("vpc_ingress_connection_status.zig").VpcIngressConnectionStatus;

/// The App Runner resource that specifies an App Runner endpoint for incoming
/// traffic. It establishes a connection between a VPC interface endpoint and a
/// App Runner
/// service, to make your App Runner service accessible from only within an
/// Amazon VPC.
pub const VpcIngressConnection = struct {
    /// The Account Id you use to create the VPC Ingress Connection resource.
    account_id: ?[]const u8,

    /// The time when the VPC Ingress Connection was created. It's in the Unix time
    /// stamp format.
    ///
    /// * Type: Timestamp
    ///
    /// * Required: Yes
    created_at: ?i64,

    /// The time when the App Runner service was deleted. It's in the Unix time
    /// stamp format.
    ///
    /// * Type: Timestamp
    ///
    /// * Required: No
    deleted_at: ?i64,

    /// The domain name associated with the VPC Ingress Connection resource.
    domain_name: ?[]const u8,

    /// Specifications for the customer’s VPC and related PrivateLink VPC endpoint
    /// that are used to associate with the VPC Ingress Connection resource.
    ingress_vpc_configuration: ?IngressVpcConfiguration,

    /// The Amazon Resource Name (ARN) of the service associated with the VPC
    /// Ingress Connection.
    service_arn: ?[]const u8,

    /// The current status of the VPC Ingress Connection.
    /// The VPC Ingress Connection displays one of the following statuses:
    /// `AVAILABLE`, `PENDING_CREATION`, `PENDING_UPDATE`,
    /// `PENDING_DELETION`,`FAILED_CREATION`, `FAILED_UPDATE`, `FAILED_DELETION`,
    /// and `DELETED`..
    status: ?VpcIngressConnectionStatus,

    /// The Amazon Resource Name (ARN) of the VPC Ingress Connection.
    vpc_ingress_connection_arn: ?[]const u8,

    /// The customer-provided VPC Ingress Connection name.
    vpc_ingress_connection_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .created_at = "CreatedAt",
        .deleted_at = "DeletedAt",
        .domain_name = "DomainName",
        .ingress_vpc_configuration = "IngressVpcConfiguration",
        .service_arn = "ServiceArn",
        .status = "Status",
        .vpc_ingress_connection_arn = "VpcIngressConnectionArn",
        .vpc_ingress_connection_name = "VpcIngressConnectionName",
    };
};
