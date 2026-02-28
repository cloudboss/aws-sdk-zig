const AuthenticationType = @import("authentication_type.zig").AuthenticationType;

/// Indicates whether the user requires a password to authenticate.
pub const Authentication = struct {
    /// The number of passwords belonging to the user. The maximum is two.
    password_count: ?i32,

    /// Indicates whether the user requires a password to authenticate.
    @"type": ?AuthenticationType,
};
