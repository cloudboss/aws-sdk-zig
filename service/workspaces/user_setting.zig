const UserSettingActionEnum = @import("user_setting_action_enum.zig").UserSettingActionEnum;
const UserSettingPermissionEnum = @import("user_setting_permission_enum.zig").UserSettingPermissionEnum;

/// Information about the user's permission settings.
pub const UserSetting = struct {
    /// Indicates the type of action.
    action: UserSettingActionEnum,

    /// Indicates the maximum character length for the specified user setting.
    maximum_length: ?i32,

    /// Indicates if the setting is enabled or disabled.
    permission: UserSettingPermissionEnum,

    pub const json_field_names = .{
        .action = "Action",
        .maximum_length = "MaximumLength",
        .permission = "Permission",
    };
};
