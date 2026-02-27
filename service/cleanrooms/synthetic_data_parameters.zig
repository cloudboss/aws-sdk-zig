const MLSyntheticDataParameters = @import("ml_synthetic_data_parameters.zig").MLSyntheticDataParameters;

/// The parameters that control how synthetic data is generated, including
/// privacy settings, column classifications, and other configuration options
/// that affect the data synthesis process.
pub const SyntheticDataParameters = union(enum) {
    /// The machine learning-specific parameters for synthetic data generation.
    ml_synthetic_data_parameters: ?MLSyntheticDataParameters,

    pub const json_field_names = .{
        .ml_synthetic_data_parameters = "mlSyntheticDataParameters",
    };
};
