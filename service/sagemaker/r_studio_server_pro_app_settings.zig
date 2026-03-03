const RStudioServerProAccessStatus = @import("r_studio_server_pro_access_status.zig").RStudioServerProAccessStatus;
const RStudioServerProUserGroup = @import("r_studio_server_pro_user_group.zig").RStudioServerProUserGroup;

/// A collection of settings that configure user interaction with the
/// `RStudioServerPro` app.
pub const RStudioServerProAppSettings = struct {
    /// Indicates whether the current user has access to the `RStudioServerPro` app.
    access_status: ?RStudioServerProAccessStatus = null,

    /// The level of permissions that the user has within the `RStudioServerPro`
    /// app. This value defaults to `User`. The `Admin` value allows the user access
    /// to the RStudio Administrative Dashboard.
    user_group: ?RStudioServerProUserGroup = null,

    pub const json_field_names = .{
        .access_status = "AccessStatus",
        .user_group = "UserGroup",
    };
};
