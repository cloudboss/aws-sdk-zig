/// Information that SageMaker Neo automatically derived about the model.
pub const DerivedInformation = struct {
    /// The data input configuration that SageMaker Neo automatically derived for
    /// the model. When SageMaker Neo derives this information, you don't need to
    /// specify the data input configuration when you create a compilation job.
    derived_data_input_config: ?[]const u8,

    pub const json_field_names = .{
        .derived_data_input_config = "DerivedDataInputConfig",
    };
};
