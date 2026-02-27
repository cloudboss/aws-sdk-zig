/// Contains the key values of `DetailsMap`:
///
/// * `PredictiveModelType` - Indicates the type of the `MLModel`.
///
/// * `Algorithm` - Indicates the algorithm that was used for the `MLModel`.
pub const DetailsAttributes = enum {
    predictive_model_type,
    algorithm,

    pub const json_field_names = .{
        .predictive_model_type = "PREDICTIVE_MODEL_TYPE",
        .algorithm = "ALGORITHM",
    };
};
