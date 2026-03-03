/// Describes VPC configuration information for fleets and image builders.
pub const VpcConfig = struct {
    /// The identifiers of the security groups for the fleet or image builder.
    security_group_ids: ?[]const []const u8 = null,

    /// The identifiers of the subnets to which a network interface is attached from
    /// the fleet instance or image builder instance. Fleet instances use one or
    /// more subnets. Image builder instances use one subnet.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
