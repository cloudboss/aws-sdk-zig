const AuthenticatedElement = @import("authenticated_element.zig").AuthenticatedElement;
const UnAuthenticatedElement = @import("un_authenticated_element.zig").UnAuthenticatedElement;

/// Describes the read, write, and delete permissions users have against your
/// storage S3 bucket.
pub const BackendStoragePermissions = struct {
    /// Lists all authenticated user read, write, and delete permissions for your S3
    /// bucket.
    authenticated: []const AuthenticatedElement,

    /// Lists all unauthenticated user read, write, and delete permissions for your
    /// S3 bucket.
    un_authenticated: ?[]const UnAuthenticatedElement,

    pub const json_field_names = .{
        .authenticated = "Authenticated",
        .un_authenticated = "UnAuthenticated",
    };
};
