const BedrockDataAutomationConfiguration = @import("bedrock_data_automation_configuration.zig").BedrockDataAutomationConfiguration;
const BedrockFoundationModelConfiguration = @import("bedrock_foundation_model_configuration.zig").BedrockFoundationModelConfiguration;
const ParsingStrategy = @import("parsing_strategy.zig").ParsingStrategy;

/// Settings for parsing document contents. If you exclude this field, the
/// default parser converts the contents of each document into text before
/// splitting it into chunks. Specify the parsing strategy to use in the
/// `parsingStrategy` field and include the relevant configuration, or omit it
/// to use the Amazon Bedrock default parser. For more information, see [Parsing
/// options for your data
/// source](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-advanced-parsing.html).
///
/// If you specify `BEDROCK_DATA_AUTOMATION` or `BEDROCK_FOUNDATION_MODEL` and
/// it fails to parse a file, the Amazon Bedrock default parser will be used
/// instead.
pub const ParsingConfiguration = struct {
    /// If you specify `BEDROCK_DATA_AUTOMATION` as the parsing strategy for
    /// ingesting your data source, use this object to modify configurations for
    /// using the Amazon Bedrock Data Automation parser.
    bedrock_data_automation_configuration: ?BedrockDataAutomationConfiguration,

    /// If you specify `BEDROCK_FOUNDATION_MODEL` as the parsing strategy for
    /// ingesting your data source, use this object to modify configurations for
    /// using a foundation model to parse documents.
    bedrock_foundation_model_configuration: ?BedrockFoundationModelConfiguration,

    /// The parsing strategy for the data source.
    parsing_strategy: ParsingStrategy,

    pub const json_field_names = .{
        .bedrock_data_automation_configuration = "bedrockDataAutomationConfiguration",
        .bedrock_foundation_model_configuration = "bedrockFoundationModelConfiguration",
        .parsing_strategy = "parsingStrategy",
    };
};
