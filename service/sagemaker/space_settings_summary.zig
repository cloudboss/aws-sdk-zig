const AppType = @import("app_type.zig").AppType;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;
const SpaceStorageSettings = @import("space_storage_settings.zig").SpaceStorageSettings;

/// Specifies summary information about the space settings.
pub const SpaceSettingsSummary = struct {
    /// The type of app created within the space.
    app_type: ?AppType,

    /// A setting that enables or disables remote access for a SageMaker space. When
    /// enabled, this allows you to connect to the remote space from your local IDE.
    remote_access: ?FeatureStatus,

    /// The storage settings for a space.
    space_storage_settings: ?SpaceStorageSettings,

    pub const json_field_names = .{
        .app_type = "AppType",
        .remote_access = "RemoteAccess",
        .space_storage_settings = "SpaceStorageSettings",
    };
};
