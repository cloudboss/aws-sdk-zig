const GameServerGroupInstanceType = @import("game_server_group_instance_type.zig").GameServerGroupInstanceType;

/// An allowed instance type for a
/// game server group. All game server groups must have at least two instance
/// types defined
/// for it. Amazon GameLift Servers FleetIQ periodically evaluates each defined
/// instance type for viability. It then
/// updates the Auto Scaling group with the list of viable instance types.
pub const InstanceDefinition = struct {
    /// An Amazon EC2 instance type designation.
    instance_type: GameServerGroupInstanceType,

    /// Instance weighting that indicates how much this instance type contributes to
    /// the total
    /// capacity of a game server group. Instance weights are used by Amazon
    /// GameLift Servers FleetIQ to calculate the
    /// instance type's cost per unit hour and better identify the most
    /// cost-effective options.
    /// For detailed information on weighting instance capacity, see [Instance
    /// Weighting](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-weighting.html) in the *Amazon Elastic Compute Cloud Auto Scaling User Guide*.
    /// Default value is "1".
    weighted_capacity: ?[]const u8,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .weighted_capacity = "WeightedCapacity",
    };
};
