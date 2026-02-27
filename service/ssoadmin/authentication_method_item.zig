const AuthenticationMethod = @import("authentication_method.zig").AuthenticationMethod;
const AuthenticationMethodType = @import("authentication_method_type.zig").AuthenticationMethodType;

/// A structure that describes an authentication method and its type.
pub const AuthenticationMethodItem = struct {
    /// A structure that describes an authentication method. The contents of this
    /// structure is determined by the `AuthenticationMethodType`.
    authentication_method: ?AuthenticationMethod,

    /// The type of authentication that is used by this method.
    authentication_method_type: ?AuthenticationMethodType,

    pub const json_field_names = .{
        .authentication_method = "AuthenticationMethod",
        .authentication_method_type = "AuthenticationMethodType",
    };
};
