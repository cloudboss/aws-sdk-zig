const ResolverEndpointDirection = @import("resolver_endpoint_direction.zig").ResolverEndpointDirection;
const Protocol = @import("protocol.zig").Protocol;
const ResolverEndpointType = @import("resolver_endpoint_type.zig").ResolverEndpointType;
const ResolverEndpointStatus = @import("resolver_endpoint_status.zig").ResolverEndpointStatus;

/// In the response to a
/// [CreateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverEndpoint.html),
/// [DeleteResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DeleteResolverEndpoint.html),
/// [GetResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverEndpoint.html),
/// Updates the name, or ResolverEndpointType for an endpoint,
/// or
/// [UpdateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_UpdateResolverEndpoint.html)
/// request, a complex type that contains settings for an existing inbound or
/// outbound Resolver endpoint.
pub const ResolverEndpoint = struct {
    /// The ARN (Amazon Resource Name) for the Resolver endpoint.
    arn: ?[]const u8 = null,

    /// The date and time that the endpoint was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?[]const u8 = null,

    /// A unique string that identifies the request that created the Resolver
    /// endpoint. The
    /// `CreatorRequestId` allows failed requests to be retried without the risk
    /// of running the operation twice.
    creator_request_id: ?[]const u8 = null,

    /// Indicates whether the Resolver endpoint allows inbound or outbound DNS
    /// queries:
    ///
    /// * `INBOUND`: allows DNS queries to your VPC from your network
    ///
    /// * `OUTBOUND`: allows DNS queries from your VPC to your network
    ///
    /// * `INBOUND_DELEGATION`: Resolver delegates queries to Route 53 private
    ///   hosted zones from your network.
    direction: ?ResolverEndpointDirection = null,

    /// The ID of the VPC that you want to create the Resolver endpoint in.
    host_vpc_id: ?[]const u8 = null,

    /// The ID of the Resolver endpoint.
    id: ?[]const u8 = null,

    /// The number of IP addresses that the Resolver endpoint can use for DNS
    /// queries.
    ip_address_count: ?i32 = null,

    /// The date and time that the endpoint was last modified, in Unix time format
    /// and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8 = null,

    /// The name that you assigned to the Resolver endpoint when you submitted a
    /// [CreateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverEndpoint.html)
    /// request.
    name: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) for the Outpost.
    outpost_arn: ?[]const u8 = null,

    /// The Amazon EC2 instance type.
    preferred_instance_type: ?[]const u8 = null,

    /// Protocols used for the endpoint. DoH-FIPS is applicable for a default
    /// inbound endpoints only.
    ///
    /// For an inbound endpoint you can apply the protocols as follows:
    ///
    /// * Do53 and DoH in combination.
    ///
    /// * Do53 and DoH-FIPS in combination.
    ///
    /// * Do53 alone.
    ///
    /// * DoH alone.
    ///
    /// * DoH-FIPS alone.
    ///
    /// * None, which is treated as Do53.
    ///
    /// For a delegation inbound endpoint you can use Do53 only.
    ///
    /// For an outbound endpoint you can apply the protocols as follows:
    ///
    /// * Do53 and DoH in combination.
    ///
    /// * Do53 alone.
    ///
    /// * DoH alone.
    ///
    /// * None, which is treated as Do53.
    protocols: ?[]const Protocol = null,

    /// The Resolver endpoint IP address type.
    resolver_endpoint_type: ?ResolverEndpointType = null,

    /// Indicates whether RNI enhanced metrics are enabled for the Resolver
    /// endpoint.
    /// When enabled, one-minute granular metrics are published in CloudWatch for
    /// each RNI associated with this endpoint.
    /// When disabled, these metrics are not published.
    rni_enhanced_metrics_enabled: ?bool = null,

    /// The ID of one or more security groups that control access to this VPC. The
    /// security group must include one or more inbound rules
    /// (for inbound endpoints) or outbound rules (for outbound endpoints). Inbound
    /// and outbound rules must allow TCP and UDP access.
    /// For inbound access, open port 53. For outbound access, open the port that
    /// you're using for DNS queries on your network.
    security_group_ids: ?[]const []const u8 = null,

    /// A code that specifies the current status of the Resolver endpoint. Valid
    /// values include the following:
    ///
    /// * `CREATING`: Resolver is creating and configuring one or more Amazon VPC
    ///   network interfaces
    /// for this endpoint.
    ///
    /// * `OPERATIONAL`: The Amazon VPC network interfaces for this endpoint are
    ///   correctly configured and
    /// able to pass inbound or outbound DNS queries between your network and
    /// Resolver.
    ///
    /// * `UPDATING`: Resolver is associating or disassociating one or more network
    ///   interfaces
    /// with this endpoint.
    ///
    /// * `AUTO_RECOVERING`: Resolver is trying to recover one or more of the
    ///   network interfaces
    /// that are associated with this endpoint. During the recovery process, the
    /// endpoint functions with limited capacity because of the
    /// limit on the number of DNS queries per IP address (per network interface).
    /// For the current limit, see
    /// [Limits on Route 53
    /// Resolver](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html#limits-api-entities-resolver).
    ///
    /// * `ACTION_NEEDED`: This endpoint is unhealthy, and Resolver can't
    ///   automatically recover it.
    /// To resolve the problem, we recommend that you check each IP address that you
    /// associated with the endpoint. For each IP address
    /// that isn't available, add another IP address and then delete the IP address
    /// that isn't available. (An endpoint must always include
    /// at least two IP addresses.) A status of `ACTION_NEEDED` can have a variety
    /// of causes. Here are two common causes:
    ///
    /// * One or more of the network interfaces that are associated with the
    ///   endpoint were deleted using Amazon VPC.
    ///
    /// * The network interface couldn't be created for some reason that's outside
    ///   the control of Resolver.
    ///
    /// * `DELETING`: Resolver is deleting this endpoint and the associated network
    ///   interfaces.
    status: ?ResolverEndpointStatus = null,

    /// A detailed description of the status of the Resolver endpoint.
    status_message: ?[]const u8 = null,

    /// Indicates whether target name server metrics are enabled for the outbound
    /// Resolver endpoint.
    /// When enabled, one-minute granular metrics are published in CloudWatch for
    /// each target name server associated with this endpoint.
    /// When disabled, these metrics are not published. This feature is not
    /// supported for inbound Resolver endpoint.
    target_name_server_metrics_enabled: ?bool = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .direction = "Direction",
        .host_vpc_id = "HostVPCId",
        .id = "Id",
        .ip_address_count = "IpAddressCount",
        .modification_time = "ModificationTime",
        .name = "Name",
        .outpost_arn = "OutpostArn",
        .preferred_instance_type = "PreferredInstanceType",
        .protocols = "Protocols",
        .resolver_endpoint_type = "ResolverEndpointType",
        .rni_enhanced_metrics_enabled = "RniEnhancedMetricsEnabled",
        .security_group_ids = "SecurityGroupIds",
        .status = "Status",
        .status_message = "StatusMessage",
        .target_name_server_metrics_enabled = "TargetNameServerMetricsEnabled",
    };
};
