const ResolverQueryLogConfigAssociationError = @import("resolver_query_log_config_association_error.zig").ResolverQueryLogConfigAssociationError;
const ResolverQueryLogConfigAssociationStatus = @import("resolver_query_log_config_association_status.zig").ResolverQueryLogConfigAssociationStatus;

/// In the response to an
/// [AssociateResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_AssociateResolverQueryLogConfig.html),
/// [DisassociateResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DisassociateResolverQueryLogConfig.html),
/// [GetResolverQueryLogConfigAssociation](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverQueryLogConfigAssociation.html),
/// or
/// [ListResolverQueryLogConfigAssociations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverQueryLogConfigAssociations.html),
/// request, a complex type that contains settings for a specified association
/// between an Amazon VPC and a query logging configuration.
pub const ResolverQueryLogConfigAssociation = struct {
    /// The date and time that the VPC was associated with the query logging
    /// configuration, in Unix time format and Coordinated Universal Time (UTC).
    creation_time: ?[]const u8 = null,

    /// If the value of `Status` is `FAILED`, the value of `Error` indicates the
    /// cause:
    ///
    /// * `DESTINATION_NOT_FOUND`: The specified destination (for example, an Amazon
    ///   S3 bucket) was deleted.
    ///
    /// * `ACCESS_DENIED`: Permissions don't allow sending logs to the destination.
    ///
    /// If the value of `Status` is a value other than `FAILED`, `Error` is null.
    @"error": ?ResolverQueryLogConfigAssociationError = null,

    /// Contains additional information about the error. If the value or `Error` is
    /// null, the value of `ErrorMessage` also is null.
    error_message: ?[]const u8 = null,

    /// The ID of the query logging association.
    id: ?[]const u8 = null,

    /// The ID of the query logging configuration that a VPC is associated with.
    resolver_query_log_config_id: ?[]const u8 = null,

    /// The ID of the Amazon VPC that is associated with the query logging
    /// configuration.
    resource_id: ?[]const u8 = null,

    /// The status of the specified query logging association. Valid values include
    /// the following:
    ///
    /// * `CREATING`: Resolver is creating an association between an Amazon VPC and
    ///   a query logging configuration.
    ///
    /// * `ACTIVE`: The association between an Amazon VPC and a query logging
    ///   configuration
    /// was successfully created. Resolver is logging queries that originate in the
    /// specified VPC.
    ///
    /// * `DELETING`: Resolver is deleting this query logging association.
    ///
    /// * `FAILED`: Resolver either couldn't create or couldn't delete the query
    ///   logging association.
    status: ?ResolverQueryLogConfigAssociationStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .@"error" = "Error",
        .error_message = "ErrorMessage",
        .id = "Id",
        .resolver_query_log_config_id = "ResolverQueryLogConfigId",
        .resource_id = "ResourceId",
        .status = "Status",
    };
};
