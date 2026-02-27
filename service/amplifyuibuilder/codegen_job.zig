const aws = @import("aws");

const CodegenJobAsset = @import("codegen_job_asset.zig").CodegenJobAsset;
const CodegenDependency = @import("codegen_dependency.zig").CodegenDependency;
const CodegenFeatureFlags = @import("codegen_feature_flags.zig").CodegenFeatureFlags;
const CodegenJobGenericDataSchema = @import("codegen_job_generic_data_schema.zig").CodegenJobGenericDataSchema;
const CodegenJobRenderConfig = @import("codegen_job_render_config.zig").CodegenJobRenderConfig;
const CodegenJobStatus = @import("codegen_job_status.zig").CodegenJobStatus;

/// Describes the configuration for a code generation job that is associated
/// with an Amplify app.
pub const CodegenJob = struct {
    /// The ID of the Amplify app associated with the code generation job.
    app_id: []const u8,

    /// The `CodegenJobAsset` to use for the code generation job.
    asset: ?CodegenJobAsset,

    /// Specifies whether to autogenerate forms in the code generation job.
    auto_generate_forms: ?bool,

    /// The time that the code generation job was created.
    created_at: ?i64,

    /// Lists the dependency packages that may be required for the project code to
    /// run.
    dependencies: ?[]const CodegenDependency,

    /// The name of the backend environment associated with the code generation job.
    environment_name: []const u8,

    features: ?CodegenFeatureFlags,

    generic_data_schema: ?CodegenJobGenericDataSchema,

    /// The unique ID for the code generation job.
    id: []const u8,

    /// The time that the code generation job was modified.
    modified_at: ?i64,

    render_config: ?CodegenJobRenderConfig,

    /// The status of the code generation job.
    status: ?CodegenJobStatus,

    /// The customized status message for the code generation job.
    status_message: ?[]const u8,

    /// One or more key-value pairs to use when tagging the code generation job.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .app_id = "appId",
        .asset = "asset",
        .auto_generate_forms = "autoGenerateForms",
        .created_at = "createdAt",
        .dependencies = "dependencies",
        .environment_name = "environmentName",
        .features = "features",
        .generic_data_schema = "genericDataSchema",
        .id = "id",
        .modified_at = "modifiedAt",
        .render_config = "renderConfig",
        .status = "status",
        .status_message = "statusMessage",
        .tags = "tags",
    };
};
