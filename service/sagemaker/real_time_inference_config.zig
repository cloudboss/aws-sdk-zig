const InstanceType = @import("instance_type.zig").InstanceType;

/// The infrastructure configuration for deploying the model to a real-time
/// inference endpoint.
pub const RealTimeInferenceConfig = struct {
    /// The number of instances of the type specified by `InstanceType`.
    instance_count: i32,

    /// The instance type the model is deployed to.
    instance_type: InstanceType,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
    };
};
