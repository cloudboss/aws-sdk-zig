const RouteServerPersistRoutesState = @import("route_server_persist_routes_state.zig").RouteServerPersistRoutesState;
const RouteServerState = @import("route_server_state.zig").RouteServerState;
const Tag = @import("tag.zig").Tag;

/// Describes a route server and its configuration.
///
/// Amazon VPC Route Server simplifies routing for traffic between workloads
/// that are deployed within a VPC and its internet gateways. With this feature,
/// VPC Route Server dynamically updates VPC and internet gateway route tables
/// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
/// for those workloads. This enables you to automatically reroute traffic
/// within a VPC, which increases the manageability of VPC routing and
/// interoperability with third-party workloads.
///
/// Route server supports the follow route table types:
///
/// * VPC route tables not associated with subnets
///
/// * Subnet route tables
///
/// * Internet gateway route tables
///
/// Route server does not support route tables associated with virtual private
/// gateways. To propagate routes into a transit gateway route table, use
/// [Transit Gateway
/// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
pub const RouteServer = struct {
    /// The Border Gateway Protocol (BGP) Autonomous System Number (ASN) for the
    /// appliance. Valid values are from 1 to 4294967295. We recommend using a
    /// private ASN in the 64512–65534 (16-bit ASN) or 4200000000–4294967294 (32-bit
    /// ASN) range.
    amazon_side_asn: ?i64 = null,

    /// The number of minutes a route server will wait after BGP is re-established
    /// to unpersist the routes in the FIB and RIB. Value must be in the range of
    /// 1-5. The default value is 1. Only valid if `persistRoutesState` is
    /// 'enabled'.
    ///
    /// If you set the duration to 1 minute, then when your network appliance
    /// re-establishes BGP with route server, it has 1 minute to relearn it's
    /// adjacent network and advertise those routes to route server before route
    /// server resumes normal functionality. In most cases, 1 minute is probably
    /// sufficient. If, however, you have concerns that your BGP network may not be
    /// capable of fully re-establishing and re-learning everything in 1 minute, you
    /// can increase the duration up to 5 minutes.
    persist_routes_duration: ?i64 = null,

    /// The current state of route persistence for the route server.
    persist_routes_state: ?RouteServerPersistRoutesState = null,

    /// The unique identifier of the route server.
    route_server_id: ?[]const u8 = null,

    /// Indicates whether SNS notifications are enabled for the route server.
    /// Enabling SNS notifications persists BGP status changes to an SNS topic
    /// provisioned by Amazon Web Services.
    sns_notifications_enabled: ?bool = null,

    /// The ARN of the SNS topic where notifications are published.
    sns_topic_arn: ?[]const u8 = null,

    /// The current state of the route server.
    state: ?RouteServerState = null,

    /// Any tags assigned to the route server.
    tags: ?[]const Tag = null,
};
