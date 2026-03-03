const ChangeType = @import("change_type.zig").ChangeType;

/// Returns a list of all broker users. Does not apply to RabbitMQ brokers.
pub const UserSummary = struct {
    /// The type of change pending for the broker user.
    pending_change: ?ChangeType = null,

    /// Required. The username of the broker user. This value can contain only
    /// alphanumeric characters, dashes, periods, underscores, and tildes (- . _ ~).
    /// This value must be 2-100 characters long.
    username: []const u8,

    pub const json_field_names = .{
        .pending_change = "PendingChange",
        .username = "Username",
    };
};
