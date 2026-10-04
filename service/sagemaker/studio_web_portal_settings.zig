const ExecutionRoleSessionNameMode = @import("execution_role_session_name_mode.zig").ExecutionRoleSessionNameMode;
const AppType = @import("app_type.zig").AppType;
const AppInstanceType = @import("app_instance_type.zig").AppInstanceType;
const MlTools = @import("ml_tools.zig").MlTools;
const HiddenSageMakerImage = @import("hidden_sage_maker_image.zig").HiddenSageMakerImage;

/// Studio settings. If these settings are applied on a user level, they take
/// priority over the settings applied on a domain level.
pub const StudioWebPortalSettings = struct {
    /// The execution role session name mode. If this value is set to
    /// `USER_IDENTITY`, the session name of the execution role corresponds to the
    /// user's identity. For IAM domains, the session name is the IAM session name
    /// used to generate the presigned URL. For IAM Identity Center domains, the
    /// session name is the username of the associated IAM Identity Center user. If
    /// this value is set to `STATIC` or is not set, the session name defaults to
    /// `SageMaker`.
    execution_role_session_name_mode: ?ExecutionRoleSessionNameMode = null,

    /// The [Applications supported in
    /// Studio](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-updated-apps.html) that are hidden from the Studio left navigation pane.
    hidden_app_types: ?[]const AppType = null,

    /// The instance types you are hiding from the Studio user interface.
    hidden_instance_types: ?[]const AppInstanceType = null,

    /// The machine learning tools that are hidden from the Studio left navigation
    /// pane.
    hidden_ml_tools: ?[]const MlTools = null,

    /// The version aliases you are hiding from the Studio user interface.
    hidden_sage_maker_image_version_aliases: ?[]const HiddenSageMakerImage = null,

    pub const json_field_names = .{
        .execution_role_session_name_mode = "ExecutionRoleSessionNameMode",
        .hidden_app_types = "HiddenAppTypes",
        .hidden_instance_types = "HiddenInstanceTypes",
        .hidden_ml_tools = "HiddenMlTools",
        .hidden_sage_maker_image_version_aliases = "HiddenSageMakerImageVersionAliases",
    };
};
