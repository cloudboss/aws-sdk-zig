const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Describes a Redshift-managed VPC endpoint.
pub const EndpointAccess = struct {
    /// The DNS address of the endpoint.
    address: ?[]const u8 = null,

    /// The cluster identifier of the cluster associated with the endpoint.
    cluster_identifier: ?[]const u8 = null,

    /// The time (UTC) that the endpoint was created.
    endpoint_create_time: ?i64 = null,

    /// The name of the endpoint.
    endpoint_name: ?[]const u8 = null,

    /// The status of the endpoint.
    endpoint_status: ?[]const u8 = null,

    /// The port number on which the cluster accepts incoming connections.
    port: ?i32 = null,

    /// The Amazon Web Services account ID of the owner of the cluster.
    resource_owner: ?[]const u8 = null,

    /// The subnet group name where Amazon Redshift chooses to deploy the endpoint.
    subnet_group_name: ?[]const u8 = null,

    vpc_endpoint: ?VpcEndpoint = null,

    /// The security groups associated with the endpoint.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership = null,
};
