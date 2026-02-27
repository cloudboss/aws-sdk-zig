/// The properties for a private VPC Output
/// When this property is specified, the output egress addresses will be created
/// in a user specified VPC
pub const VpcOutputSettings = struct {
    /// List of public address allocation ids to associate with ENIs that will be
    /// created in Output VPC.
    /// Must specify one for SINGLE_PIPELINE, two for STANDARD channels
    public_address_allocation_ids: ?[]const []const u8,

    /// A list of up to 5 EC2 VPC security group IDs to attach to the Output VPC
    /// network interfaces.
    /// If none are specified then the VPC default security group will be used
    security_group_ids: ?[]const []const u8,

    /// A list of VPC subnet IDs from the same VPC.
    /// If STANDARD channel, subnet IDs must be mapped to two unique availability
    /// zones (AZ).
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .public_address_allocation_ids = "PublicAddressAllocationIds",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
