const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;

/// Specifies an instance type and its priority for a heterogeneous endpoint.
/// Use instance pools to configure a production variant with multiple instance
/// types, enabling the endpoint to provision instances across different types
/// based on priority.
pub const InstancePool = struct {
    /// The ML compute instance type for the instance pool.
    instance_type: ProductionVariantInstanceType,

    /// The name of a SageMaker model to use for this instance pool instead of the
    /// model specified for the production variant. Use this to deploy a different
    /// model optimized for the instance type in this pool.
    model_name_override: ?[]const u8 = null,

    /// The priority for the instance pool. SageMaker attempts to provision
    /// instances in order of priority, starting with the lowest value. If instances
    /// for a higher-priority pool are unavailable, SageMaker attempts to provision
    /// from the next pool.
    ///
    /// Valid values: 1 to 5, where 1 is the highest priority.
    priority: i32,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .model_name_override = "ModelNameOverride",
        .priority = "Priority",
    };
};
