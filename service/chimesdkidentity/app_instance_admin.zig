const Identity = @import("identity.zig").Identity;

/// The name and ARN of the admin for the `AppInstance`.
pub const AppInstanceAdmin = struct {
    /// The `AppInstanceAdmin` data.
    admin: ?Identity,

    /// The ARN of the `AppInstance` for which the user is an administrator.
    app_instance_arn: ?[]const u8,

    /// The time at which an administrator was created.
    created_timestamp: ?i64,

    pub const json_field_names = .{
        .admin = "Admin",
        .app_instance_arn = "AppInstanceArn",
        .created_timestamp = "CreatedTimestamp",
    };
};
