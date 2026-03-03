const AppType = @import("app_type.zig").AppType;
const AppInstanceType = @import("app_instance_type.zig").AppInstanceType;
const MlTools = @import("ml_tools.zig").MlTools;
const HiddenSageMakerImage = @import("hidden_sage_maker_image.zig").HiddenSageMakerImage;

/// Studio settings. If these settings are applied on a user level, they take
/// priority over the settings applied on a domain level.
pub const StudioWebPortalSettings = struct {
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
        .hidden_app_types = "HiddenAppTypes",
        .hidden_instance_types = "HiddenInstanceTypes",
        .hidden_ml_tools = "HiddenMlTools",
        .hidden_sage_maker_image_version_aliases = "HiddenSageMakerImageVersionAliases",
    };
};
