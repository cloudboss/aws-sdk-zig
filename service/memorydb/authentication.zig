const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// Denotes the user's authentication properties, such as whether it requires a
/// password to authenticate. Used in output responses.
pub const Authentication = struct {
    /// The number of passwords belonging to the user. The maximum is two.
    password_count: ?i32,

    /// Indicates whether the user requires a password to authenticate.
    @"type": ?AuthenticationType,

    pub const json_field_names = .{
        .password_count = "PasswordCount",
        .@"type" = "Type",
    };
};
