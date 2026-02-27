const Allowed = @import("allowed.zig").Allowed;
const AuthDecision = @import("auth_decision.zig").AuthDecision;
const AuthInfo = @import("auth_info.zig").AuthInfo;
const Denied = @import("denied.zig").Denied;

/// The authorizer result.
pub const AuthResult = struct {
    /// The policies and statements that allowed the specified action.
    allowed: ?Allowed,

    /// The final authorization decision of this scenario. Multiple statements are
    /// taken into
    /// account when determining the authorization decision. An explicit deny
    /// statement can
    /// override multiple allow statements.
    auth_decision: ?AuthDecision,

    /// Authorization information.
    auth_info: ?AuthInfo,

    /// The policies and statements that denied the specified action.
    denied: ?Denied,

    /// Contains any missing context values found while evaluating policy.
    missing_context_values: ?[]const []const u8,

    pub const json_field_names = .{
        .allowed = "allowed",
        .auth_decision = "authDecision",
        .auth_info = "authInfo",
        .denied = "denied",
        .missing_context_values = "missingContextValues",
    };
};
