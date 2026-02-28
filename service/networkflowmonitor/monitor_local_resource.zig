const MonitorLocalResourceType = @import("monitor_local_resource_type.zig").MonitorLocalResourceType;

/// A local resource is the host where the agent is installed. Local resources
/// can be a a subnet, a VPC, an Availability Zone, an EKS cluster or an Amazon
/// Web Services Region.
pub const MonitorLocalResource = struct {
    /// The identifier of the local resource. The values you can specify are the
    /// following:
    ///
    /// * For a VPC, subnet or EKS cluster, this identifier is the VPC Amazon
    ///   Resource Name (ARN), subnet ARN or cluster ARN.
    /// * For an Availability Zone, this identifier is the AZ name, for example,
    ///   us-west-2b.
    /// * For a Region, this identifier is the Region name, for example, us-west-2.
    identifier: []const u8,

    /// The type of the local resource. Valid values are `AWS::EC2::VPC`
    /// `AWS::AvailabilityZone`, `AWS::EC2::Subnet`, `AWS::EKS::Cluster`, or
    /// `AWS::Region`.
    @"type": MonitorLocalResourceType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .@"type" = "type",
    };
};
