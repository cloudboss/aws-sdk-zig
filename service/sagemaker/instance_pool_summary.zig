const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;

/// A summary of an instance pool for a production variant, including the
/// instance type and the current number of instances.
pub const InstancePoolSummary = struct {
    /// The current number of instances of this type in the instance pool.
    current_instance_count: i32,

    /// The ML compute instance type for the instance pool.
    instance_type: ProductionVariantInstanceType,

    pub const json_field_names = .{
        .current_instance_count = "CurrentInstanceCount",
        .instance_type = "InstanceType",
    };
};
