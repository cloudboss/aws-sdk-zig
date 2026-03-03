const AppType = @import("app_type.zig").AppType;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;
const AppStatus = @import("app_status.zig").AppStatus;

/// Details about an Amazon SageMaker AI app.
pub const AppDetails = struct {
    /// The name of the app.
    app_name: ?[]const u8 = null,

    /// The type of app.
    app_type: ?AppType = null,

    /// The creation time.
    creation_time: ?i64 = null,

    /// The domain ID.
    domain_id: ?[]const u8 = null,

    resource_spec: ?ResourceSpec = null,

    /// The name of the space.
    space_name: ?[]const u8 = null,

    /// The status.
    status: ?AppStatus = null,

    /// The user profile name.
    user_profile_name: ?[]const u8 = null,

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
