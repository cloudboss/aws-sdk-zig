const BedrockModelSpecification = @import("bedrock_model_specification.zig").BedrockModelSpecification;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;

/// Details about the the configuration of the built-in `Amazon.QnAIntent`.
pub const QnAIntentConfiguration = struct {
    bedrock_model_configuration: ?BedrockModelSpecification,

    /// Contains details about the configuration of the data source used for the
    /// `AMAZON.QnAIntent`.
    data_source_configuration: ?DataSourceConfiguration,

    pub const json_field_names = .{
        .bedrock_model_configuration = "bedrockModelConfiguration",
        .data_source_configuration = "dataSourceConfiguration",
    };
};
