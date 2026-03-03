const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;

/// The Amazon GameLift Servers service limits for an Amazon EC2 instance type
/// and current utilization. Amazon GameLift Servers
/// allows Amazon Web Services accounts a maximum number of instances, per
/// instance type, per Amazon Web Services Region
/// or location, for use with Amazon GameLift Servers. You can request an limit
/// increase for your account by
/// using the **Service limits** page in the Amazon GameLift Servers
/// console.
pub const EC2InstanceLimit = struct {
    /// The number of instances for the specified type and location that are
    /// currently being
    /// used by the Amazon Web Services account.
    current_instances: ?i32 = null,

    /// The name of an Amazon EC2 instance type. See [Amazon Elastic Compute Cloud
    /// Instance Types](http://aws.amazon.com/ec2/instance-types/) for detailed
    /// descriptions.
    ec2_instance_type: ?EC2InstanceType = null,

    /// The number of instances that is allowed for the specified instance type and
    /// location.
    instance_limit: ?i32 = null,

    /// An Amazon Web Services Region code, such as `us-west-2`.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_instances = "CurrentInstances",
        .ec2_instance_type = "EC2InstanceType",
        .instance_limit = "InstanceLimit",
        .location = "Location",
    };
};
