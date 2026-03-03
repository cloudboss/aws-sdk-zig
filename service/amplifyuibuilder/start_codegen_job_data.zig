const aws = @import("aws");

const CodegenFeatureFlags = @import("codegen_feature_flags.zig").CodegenFeatureFlags;
const CodegenJobGenericDataSchema = @import("codegen_job_generic_data_schema.zig").CodegenJobGenericDataSchema;
const CodegenJobRenderConfig = @import("codegen_job_render_config.zig").CodegenJobRenderConfig;

/// The code generation job resource configuration.
pub const StartCodegenJobData = struct {
    /// Specifies whether to autogenerate forms in the code generation job.
    auto_generate_forms: ?bool = null,

    /// The feature flags for a code generation job.
    features: ?CodegenFeatureFlags = null,

    /// The data schema to use for a code generation job.
    generic_data_schema: ?CodegenJobGenericDataSchema = null,

    /// The code generation configuration for the codegen job.
    render_config: CodegenJobRenderConfig,

    /// One or more key-value pairs to use when tagging the code generation job
    /// data.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auto_generate_forms = "autoGenerateForms",
        .features = "features",
        .generic_data_schema = "genericDataSchema",
        .render_config = "renderConfig",
        .tags = "tags",
    };
};
