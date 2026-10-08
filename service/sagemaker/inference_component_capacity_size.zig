const InferenceComponentCapacitySizeType = @import("inference_component_capacity_size_type.zig").InferenceComponentCapacitySizeType;

/// Specifies the type and size of the endpoint capacity to activate for a
/// rolling deployment or a rollback strategy. You can specify your batches as
/// either of the following:
///
/// * A count of inference component copies
/// * The overall percentage or your fleet
///
/// For a rollback strategy, if you don't specify the fields in this object, or
/// if you set the `Value` parameter to 100%, then SageMaker AI uses a
/// blue/green rollback strategy and rolls all traffic back to the blue fleet.
pub const InferenceComponentCapacitySize = struct {
    /// Specifies the endpoint capacity type.
    ///
    /// **COPY_COUNT**
    ///
    /// The endpoint activates based on the number of inference component copies.
    ///
    /// **CAPACITY_PERCENT**
    ///
    /// The endpoint activates based on the specified percentage of capacity.
    type: InferenceComponentCapacitySizeType,

    /// Defines the capacity size, either as a number of inference component copies
    /// or a capacity percentage.
    value: i32,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
