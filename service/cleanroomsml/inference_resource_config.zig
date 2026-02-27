const InferenceInstanceType = @import("inference_instance_type.zig").InferenceInstanceType;

/// Defines the resources used to perform model inference.
pub const InferenceResourceConfig = struct {
    /// The number of instances to use.
    instance_count: i32 = 1,

    /// The type of instance that is used to perform model inference.
    instance_type: InferenceInstanceType,

    pub const json_field_names = .{
        .instance_count = "instanceCount",
        .instance_type = "instanceType",
    };
};
