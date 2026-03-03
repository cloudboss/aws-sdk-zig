const AnalysisParameter = @import("analysis_parameter.zig").AnalysisParameter;
const ErrorMessageConfiguration = @import("error_message_configuration.zig").ErrorMessageConfiguration;
const AnalysisFormat = @import("analysis_format.zig").AnalysisFormat;
const AnalysisSchema = @import("analysis_schema.zig").AnalysisSchema;
const AnalysisSource = @import("analysis_source.zig").AnalysisSource;
const AnalysisSourceMetadata = @import("analysis_source_metadata.zig").AnalysisSourceMetadata;
const SyntheticDataParameters = @import("synthetic_data_parameters.zig").SyntheticDataParameters;
const AnalysisTemplateValidationStatusDetail = @import("analysis_template_validation_status_detail.zig").AnalysisTemplateValidationStatusDetail;

/// The analysis template within a collaboration.
pub const CollaborationAnalysisTemplate = struct {
    /// The analysis parameters that have been specified in the analysis template.
    analysis_parameters: ?[]const AnalysisParameter = null,

    /// The Amazon Resource Name (ARN) of the analysis template.
    arn: []const u8,

    /// The unique ARN for the analysis template’s associated collaboration.
    collaboration_arn: []const u8,

    /// A unique identifier for the collaboration that the analysis templates belong
    /// to. Currently accepts collaboration ID.
    collaboration_id: []const u8,

    /// The time that the analysis template within a collaboration was created.
    create_time: i64,

    /// The identifier used to reference members of the collaboration. Currently
    /// only supports Amazon Web Services account ID.
    creator_account_id: []const u8,

    /// The description of the analysis template.
    description: ?[]const u8 = null,

    /// The configuration that specifies the level of detail in error messages
    /// returned by analyses using this template. When set to `DETAILED`, error
    /// messages include more information to help troubleshoot issues with PySpark
    /// jobs. Detailed error messages may expose underlying data, including
    /// sensitive information. Recommended for faster troubleshooting in development
    /// and testing environments.
    error_message_configuration: ?ErrorMessageConfiguration = null,

    /// The format of the analysis template in the collaboration.
    format: AnalysisFormat,

    /// The identifier of the analysis template.
    id: []const u8,

    /// The name of the analysis template.
    name: []const u8,

    /// The entire schema object.
    schema: AnalysisSchema,

    /// The source of the analysis template within a collaboration.
    source: ?AnalysisSource = null,

    /// The source metadata for the collaboration analysis template.
    source_metadata: ?AnalysisSourceMetadata = null,

    /// The synthetic data generation parameters configured for this collaboration
    /// analysis template.
    synthetic_data_parameters: ?SyntheticDataParameters = null,

    /// The time that the analysis template in the collaboration was last updated.
    update_time: i64,

    /// The validations that were performed.
    validations: ?[]const AnalysisTemplateValidationStatusDetail = null,

    pub const json_field_names = .{
        .analysis_parameters = "analysisParameters",
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .description = "description",
        .error_message_configuration = "errorMessageConfiguration",
        .format = "format",
        .id = "id",
        .name = "name",
        .schema = "schema",
        .source = "source",
        .source_metadata = "sourceMetadata",
        .synthetic_data_parameters = "syntheticDataParameters",
        .update_time = "updateTime",
        .validations = "validations",
    };
};
