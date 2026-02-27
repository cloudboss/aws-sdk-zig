/// The value of a hyperparameter. Only one of `NumberValue` or `StringValue`
/// can be specified.
///
/// This object is specified in the
/// [CreateTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrialComponent.html) request.
pub const TrialComponentParameterValue = union(enum) {
    /// The numeric value of a numeric hyperparameter. If you specify a value for
    /// this parameter, you can't specify the `StringValue` parameter.
    number_value: ?f64,
    /// The string value of a categorical hyperparameter. If you specify a value for
    /// this parameter, you can't specify the `NumberValue` parameter.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .number_value = "NumberValue",
        .string_value = "StringValue",
    };
};
