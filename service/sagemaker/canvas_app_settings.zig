const DirectDeploySettings = @import("direct_deploy_settings.zig").DirectDeploySettings;
const EmrServerlessSettings = @import("emr_serverless_settings.zig").EmrServerlessSettings;
const GenerativeAiSettings = @import("generative_ai_settings.zig").GenerativeAiSettings;
const IdentityProviderOAuthSetting = @import("identity_provider_o_auth_setting.zig").IdentityProviderOAuthSetting;
const KendraSettings = @import("kendra_settings.zig").KendraSettings;
const ModelRegisterSettings = @import("model_register_settings.zig").ModelRegisterSettings;
const TimeSeriesForecastingSettings = @import("time_series_forecasting_settings.zig").TimeSeriesForecastingSettings;
const WorkspaceSettings = @import("workspace_settings.zig").WorkspaceSettings;

/// The SageMaker Canvas application settings.
pub const CanvasAppSettings = struct {
    /// The model deployment settings for the SageMaker Canvas application.
    direct_deploy_settings: ?DirectDeploySettings,

    /// The settings for running Amazon EMR Serverless data processing jobs in
    /// SageMaker Canvas.
    emr_serverless_settings: ?EmrServerlessSettings,

    /// The generative AI settings for the SageMaker Canvas application.
    generative_ai_settings: ?GenerativeAiSettings,

    /// The settings for connecting to an external data source with OAuth.
    identity_provider_o_auth_settings: ?[]const IdentityProviderOAuthSetting,

    /// The settings for document querying.
    kendra_settings: ?KendraSettings,

    /// The model registry settings for the SageMaker Canvas application.
    model_register_settings: ?ModelRegisterSettings,

    /// Time series forecast settings for the SageMaker Canvas application.
    time_series_forecasting_settings: ?TimeSeriesForecastingSettings,

    /// The workspace settings for the SageMaker Canvas application.
    workspace_settings: ?WorkspaceSettings,

    pub const json_field_names = .{
        .direct_deploy_settings = "DirectDeploySettings",
        .emr_serverless_settings = "EmrServerlessSettings",
        .generative_ai_settings = "GenerativeAiSettings",
        .identity_provider_o_auth_settings = "IdentityProviderOAuthSettings",
        .kendra_settings = "KendraSettings",
        .model_register_settings = "ModelRegisterSettings",
        .time_series_forecasting_settings = "TimeSeriesForecastingSettings",
        .workspace_settings = "WorkspaceSettings",
    };
};
