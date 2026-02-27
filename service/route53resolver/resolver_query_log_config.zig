const ShareStatus = @import("share_status.zig").ShareStatus;
const ResolverQueryLogConfigStatus = @import("resolver_query_log_config_status.zig").ResolverQueryLogConfigStatus;

/// In the response to a
/// [CreateResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverQueryLogConfig.html),
/// [DeleteResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DeleteResolverQueryLogConfig.html),
/// [GetResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverQueryLogConfig.html),
/// or
/// [ListResolverQueryLogConfigs](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverQueryLogConfigs.html)
/// request, a complex type that contains settings for one query logging
/// configuration.
pub const ResolverQueryLogConfig = struct {
    /// The ARN for the query logging configuration.
    arn: ?[]const u8,

    /// The number of VPCs that are associated with the query logging configuration.
    association_count: i32 = 0,

    /// The date and time that the query logging configuration was created, in Unix
    /// time format and Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// A unique string that identifies the request that created the query logging
    /// configuration.
    /// The `CreatorRequestId` allows failed requests to be retried without the risk
    /// of running the operation twice.
    creator_request_id: ?[]const u8,

    /// The ARN of the resource that you want Resolver to send query logs: an Amazon
    /// S3 bucket, a CloudWatch Logs log group, or
    /// a Kinesis Data Firehose delivery stream.
    destination_arn: ?[]const u8,

    /// The ID for the query logging configuration.
    id: ?[]const u8,

    /// The name of the query logging configuration.
    name: ?[]const u8,

    /// The Amazon Web Services account ID for the account that created the query
    /// logging configuration.
    owner_id: ?[]const u8,

    /// An indication of whether the query logging configuration is shared with
    /// other Amazon Web Services accounts, or was shared with the current account
    /// by another
    /// Amazon Web Services account. Sharing is configured through Resource Access
    /// Manager (RAM).
    share_status: ?ShareStatus,

    /// The status of the specified query logging configuration. Valid values
    /// include the following:
    ///
    /// * `CREATING`: Resolver is creating the query logging configuration.
    ///
    /// * `CREATED`: The query logging configuration was successfully created.
    /// Resolver is logging queries that originate in the specified VPC.
    ///
    /// * `DELETING`: Resolver is deleting this query logging configuration.
    ///
    /// * `FAILED`: Resolver can't deliver logs to the location that is specified in
    ///   the query logging configuration.
    /// Here are two common causes:
    ///
    /// * The specified destination (for example, an Amazon S3 bucket) was deleted.
    ///
    /// * Permissions don't allow sending logs to the destination.
    status: ?ResolverQueryLogConfigStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .association_count = "AssociationCount",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .destination_arn = "DestinationArn",
        .id = "Id",
        .name = "Name",
        .owner_id = "OwnerId",
        .share_status = "ShareStatus",
        .status = "Status",
    };
};
