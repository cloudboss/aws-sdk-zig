const SignInOptions = @import("sign_in_options.zig").SignInOptions;
const ApplicationVisibility = @import("application_visibility.zig").ApplicationVisibility;

/// A structure that describes the options for the access portal associated with
/// an application.
pub const PortalOptions = struct {
    /// A structure that describes the sign-in options for the access portal.
    sign_in_options: ?SignInOptions = null,

    /// Indicates whether this application is visible in the access portal.
    visibility: ApplicationVisibility = .enabled,

    pub const json_field_names = .{
        .sign_in_options = "SignInOptions",
        .visibility = "Visibility",
    };
};
