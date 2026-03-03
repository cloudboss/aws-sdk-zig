const Action = @import("action.zig").Action;
const Permission = @import("permission.zig").Permission;

/// Describes an action and whether the action is enabled or disabled for users
/// during their streaming sessions.
pub const UserSetting = struct {
    /// The action that is enabled or disabled.
    action: Action,

    /// Specifies the number of characters that can be copied by end users from the
    /// local device to the remote session, and to the local device from the remote
    /// session.
    ///
    /// This can be specified only for the `CLIPBOARD_COPY_FROM_LOCAL_DEVICE` and
    /// `CLIPBOARD_COPY_TO_LOCAL_DEVICE` actions.
    ///
    /// This defaults to 20,971,520 (20 MB) when unspecified and the permission is
    /// `ENABLED`. This can't be specified when the permission is `DISABLED`.
    ///
    /// The value can be between 1 and 20,971,520 (20 MB).
    maximum_length: ?i32 = null,

    /// Indicates whether the action is enabled or disabled.
    permission: Permission,

    pub const json_field_names = .{
        .action = "Action",
        .maximum_length = "MaximumLength",
        .permission = "Permission",
    };
};
