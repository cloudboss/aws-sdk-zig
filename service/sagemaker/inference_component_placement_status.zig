const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;

/// The placement status of an inference component on a specific instance type.
/// Shows the number of inference component copies currently placed on instances
/// of a given type.
pub const InferenceComponentPlacementStatus = struct {
    /// The number of inference component copies currently placed on instances of
    /// this type.
    current_copy_count: i32,

    /// The ML compute instance type where the inference component copies are
    /// placed.
    instance_type: ProductionVariantInstanceType,

    pub const json_field_names = .{
        .current_copy_count = "CurrentCopyCount",
        .instance_type = "InstanceType",
    };
};
