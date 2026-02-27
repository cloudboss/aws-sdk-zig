const aws = @import("aws");

const ModelOutputDataFormat = @import("model_output_data_format.zig").ModelOutputDataFormat;

/// Provides the Amazon Sagemaker model output configuration.
pub const ModelOutputConfiguration = struct {
    /// A map of CSV index values in the SageMaker response to the Amazon Fraud
    /// Detector variables.
    csv_index_to_variable_map: ?[]const aws.map.StringMapEntry,

    /// The format of the model output configuration.
    format: ModelOutputDataFormat,

    /// A map of JSON keys in response from SageMaker to the Amazon Fraud Detector
    /// variables.
    json_key_to_variable_map: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .csv_index_to_variable_map = "csvIndexToVariableMap",
        .format = "format",
        .json_key_to_variable_map = "jsonKeyToVariableMap",
    };
};
