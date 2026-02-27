const IamAuthenticationMethod = @import("iam_authentication_method.zig").IamAuthenticationMethod;

/// A structure that describes an authentication method that can be used by an
/// application.
pub const AuthenticationMethod = union(enum) {
    /// A structure that describes details for IAM authentication.
    iam: ?IamAuthenticationMethod,

    pub const json_field_names = .{
        .iam = "Iam",
    };
};
