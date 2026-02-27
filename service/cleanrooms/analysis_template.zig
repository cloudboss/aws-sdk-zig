const AnalysisParameter = @import("analysis_parameter.zig").AnalysisParameter;
const ErrorMessageConfiguration = @import("error_message_configuration.zig").ErrorMessageConfiguration;
const AnalysisFormat = @import("analysis_format.zig").AnalysisFormat;
const AnalysisSchema = @import("analysis_schema.zig").AnalysisSchema;
const AnalysisSource = @import("analysis_source.zig").AnalysisSource;
const AnalysisSourceMetadata = @import("analysis_source_metadata.zig").AnalysisSourceMetadata;
const SyntheticDataParameters = @import("synthetic_data_parameters.zig").SyntheticDataParameters;
const AnalysisTemplateValidationStatusDetail = @import("analysis_template_validation_status_detail.zig").AnalysisTemplateValidationStatusDetail;

/// The analysis template.
pub const AnalysisTemplate = struct {
    /// The parameters of the analysis template.
    analysis_parameters: ?[]const AnalysisParameter,

    /// The Amazon Resource Name (ARN) of the analysis template.
    arn: []const u8,

    /// The unique ARN for the analysis template’s associated collaboration.
    collaboration_arn: []const u8,

    /// The unique ID for the associated collaboration of the analysis template.
    collaboration_id: []const u8,

    /// The time that the analysis template was created.
    create_time: i64,

    /// The description of the analysis template.
    description: ?[]const u8,

    /// The configuration that specifies the level of detail in error messages
    /// returned by analyses using this template. When set to `DETAILED`, error
    /// messages include more information to help troubleshoot issues with PySpark
    /// jobs. Detailed error messages may expose underlying data, including
    /// sensitive information. Recommended for faster troubleshooting in development
    /// and testing environments.
    error_message_configuration: ?ErrorMessageConfiguration,

    /// The format of the analysis template.
    format: AnalysisFormat,

    /// The identifier for the analysis template.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the member who created the analysis
    /// template.
    membership_arn: []const u8,

    /// The identifier of a member who created the analysis template.
    membership_id: []const u8,

    /// The name of the analysis template.
    name: []const u8,

    /// The entire schema object.
    schema: AnalysisSchema,

    /// The source of the analysis template.
    source: AnalysisSource,

    /// The source metadata for the analysis template.
    source_metadata: ?AnalysisSourceMetadata,

    /// The parameters used to generate synthetic data for this analysis template.
    synthetic_data_parameters: ?SyntheticDataParameters,

    /// The time that the analysis template was last updated.
    update_time: i64,

    /// Information about the validations performed on the analysis template.
    validations: ?[]const AnalysisTemplateValidationStatusDetail,

    pub const json_field_names = .{
        .analysis_parameters = "analysisParameters",
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .error_message_configuration = "errorMessageConfiguration",
        .format = "format",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .schema = "schema",
        .source = "source",
        .source_metadata = "sourceMetadata",
        .synthetic_data_parameters = "syntheticDataParameters",
        .update_time = "updateTime",
        .validations = "validations",
    };
};
