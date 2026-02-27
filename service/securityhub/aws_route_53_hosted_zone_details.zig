const AwsRoute53HostedZoneObjectDetails = @import("aws_route_53_hosted_zone_object_details.zig").AwsRoute53HostedZoneObjectDetails;
const AwsRoute53QueryLoggingConfigDetails = @import("aws_route_53_query_logging_config_details.zig").AwsRoute53QueryLoggingConfigDetails;
const AwsRoute53HostedZoneVpcDetails = @import("aws_route_53_hosted_zone_vpc_details.zig").AwsRoute53HostedZoneVpcDetails;

/// Provides details about a specified Amazon Route 53 hosted zone, including
/// the four name servers assigned to
/// the hosted zone. A hosted zone represents a collection of records that can
/// be managed together, belonging to a single parent
/// domain name.
pub const AwsRoute53HostedZoneDetails = struct {
    /// An object that contains information about the specified hosted zone.
    hosted_zone: ?AwsRoute53HostedZoneObjectDetails,

    /// An object that contains a list of the authoritative name servers for a
    /// hosted zone or for a reusable delegation set.
    name_servers: ?[]const []const u8,

    /// An array that contains one `QueryLoggingConfig` element for each DNS query
    /// logging configuration that is
    /// associated with the current Amazon Web Services account.
    query_logging_config: ?AwsRoute53QueryLoggingConfigDetails,

    /// An object that contains information about the Amazon Virtual Private Clouds
    /// (Amazon VPCs) that are associated with
    /// the specified hosted zone.
    vpcs: ?[]const AwsRoute53HostedZoneVpcDetails,

    pub const json_field_names = .{
        .hosted_zone = "HostedZone",
        .name_servers = "NameServers",
        .query_logging_config = "QueryLoggingConfig",
        .vpcs = "Vpcs",
    };
};
