const ChangeType = @import("change_type.zig").ChangeType;

/// Returns information about the status of the changes pending for the ActiveMQ
/// user.
pub const UserPendingChanges = struct {
    /// Enables access to the the ActiveMQ Web Console for the ActiveMQ user.
    console_access: ?bool = null,

    /// The list of groups (20 maximum) to which the ActiveMQ user belongs. This
    /// value can contain only alphanumeric characters, dashes, periods,
    /// underscores, and tildes (- . _ ~). This value must be 2-100 characters long.
    groups: ?[]const []const u8 = null,

    /// Required. The type of change pending for the ActiveMQ user.
    pending_change: ChangeType,

    pub const json_field_names = .{
        .console_access = "ConsoleAccess",
        .groups = "Groups",
        .pending_change = "PendingChange",
    };
};
