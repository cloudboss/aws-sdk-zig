const AppType = @import("app_type.zig").AppType;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;
const AppStatus = @import("app_status.zig").AppStatus;

/// Details about an Amazon SageMaker AI app.
pub const AppDetails = struct {
    /// The name of the app.
    app_name: ?[]const u8,

    /// The type of app.
    app_type: ?AppType,

    /// The creation time.
    creation_time: ?i64,

    /// The domain ID.
    domain_id: ?[]const u8,

    resource_spec: ?ResourceSpec,

    /// The name of the space.
    space_name: ?[]const u8,

    /// The status.
    status: ?AppStatus,

    /// The user profile name.
    user_profile_name: ?[]const u8,

    pub const json_field_names = .{
        .app_name = "AppName",
        .app_type = "AppType",
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .resource_spec = "ResourceSpec",
        .space_name = "SpaceName",
        .status = "Status",
        .user_profile_name = "UserProfileName",
    };
};
