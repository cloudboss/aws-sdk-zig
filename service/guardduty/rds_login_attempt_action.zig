const LoginAttribute = @import("login_attribute.zig").LoginAttribute;
const RemoteIpDetails = @import("remote_ip_details.zig").RemoteIpDetails;

/// Indicates that a login attempt was made to the potentially compromised
/// database from a
/// remote IP address.
pub const RdsLoginAttemptAction = struct {
    /// Indicates the login attributes used in the login attempt.
    login_attributes: ?[]const LoginAttribute = null,

    remote_ip_details: ?RemoteIpDetails = null,

    pub const json_field_names = .{
        .login_attributes = "LoginAttributes",
        .remote_ip_details = "RemoteIpDetails",
    };
};
