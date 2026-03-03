const aws = @import("aws");

/// The parameters for the protected job.
pub const ProtectedJobParameters = struct {
    /// The ARN of the analysis template.
    analysis_template_arn: []const u8,

    /// Runtime configuration values passed to the PySpark analysis script.
    /// Parameter names and types must match those defined in the analysis template.
    parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .analysis_template_arn = "analysisTemplateArn",
        .parameters = "parameters",
    };
};
