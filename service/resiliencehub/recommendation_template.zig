const aws = @import("aws");

const TemplateFormat = @import("template_format.zig").TemplateFormat;
const RenderRecommendationType = @import("render_recommendation_type.zig").RenderRecommendationType;
const RecommendationTemplateStatus = @import("recommendation_template_status.zig").RecommendationTemplateStatus;
const S3Location = @import("s3_location.zig").S3Location;

/// Defines a recommendation template created with the
/// CreateRecommendationTemplate action.
pub const RecommendationTemplate = struct {
    /// Amazon Resource Name (ARN) of the Resilience Hub application. The format for
    /// this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app/`app-id`. For more
    /// information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    app_arn: ?[]const u8,

    /// Amazon Resource Name (ARN) of the assessment. The format for this ARN is:
    /// arn:`partition`:resiliencehub:`region`:`account`:app-assessment/`app-id`.
    /// For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    assessment_arn: []const u8,

    /// The end time for the action.
    end_time: ?i64,

    /// Format of the recommendation template.
    ///
    /// **CfnJson**
    ///
    /// The template is CloudFormation JSON.
    ///
    /// **CfnYaml**
    ///
    /// The template is CloudFormation YAML.
    format: TemplateFormat,

    /// Message for the recommendation template.
    message: ?[]const u8,

    /// Name for the recommendation template.
    name: []const u8,

    /// Indicates if replacements are needed.
    needs_replacements: ?bool,

    /// Identifiers for the recommendations used in the recommendation template.
    recommendation_ids: ?[]const []const u8,

    /// Amazon Resource Name (ARN) for the recommendation template.
    recommendation_template_arn: []const u8,

    /// An array of strings that specify the recommendation template type or types.
    ///
    /// **Alarm**
    ///
    /// The template is an AlarmRecommendation template.
    ///
    /// **Sop**
    ///
    /// The template is a SopRecommendation template.
    ///
    /// **Test**
    ///
    /// The template is a TestRecommendation template.
    recommendation_types: []const RenderRecommendationType,

    /// The start time for the action.
    start_time: ?i64,

    /// Status of the action.
    status: RecommendationTemplateStatus,

    /// Tags assigned to the resource. A tag is a label that you assign to an Amazon
    /// Web Services resource.
    /// Each tag consists of a key/value pair.
    tags: ?[]const aws.map.StringMapEntry,

    /// The file location of the template.
    templates_location: ?S3Location,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .assessment_arn = "assessmentArn",
        .end_time = "endTime",
        .format = "format",
        .message = "message",
        .name = "name",
        .needs_replacements = "needsReplacements",
        .recommendation_ids = "recommendationIds",
        .recommendation_template_arn = "recommendationTemplateArn",
        .recommendation_types = "recommendationTypes",
        .start_time = "startTime",
        .status = "status",
        .tags = "tags",
        .templates_location = "templatesLocation",
    };
};
