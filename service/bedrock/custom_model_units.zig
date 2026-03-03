/// A `CustomModelUnit` (CMU) is an abstract view of the hardware utilization
/// that Amazon Bedrock needs to host a single copy of your custom model. A
/// model copy represents a single instance of your imported model that is ready
/// to serve inference requests. Amazon Bedrock determines the number of custom
/// model units that a model copy needs when you import the custom model.
///
/// You can use `CustomModelUnits` to estimate the cost of running your custom
/// model. For more information, see Calculate the cost of running a custom
/// model in the Amazon Bedrock user guide.
pub const CustomModelUnits = struct {
    /// The number of custom model units used to host a model copy.
    custom_model_units_per_model_copy: ?i32 = null,

    /// The version of the custom model unit. Use to determine the billing rate for
    /// the custom model unit.
    custom_model_units_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_model_units_per_model_copy = "customModelUnitsPerModelCopy",
        .custom_model_units_version = "customModelUnitsVersion",
    };
};
