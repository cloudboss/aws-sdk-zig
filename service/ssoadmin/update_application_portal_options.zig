const SignInOptions = @import("sign_in_options.zig").SignInOptions;

/// A structure that describes the options for the access portal associated with
/// an application that can be updated.
pub const UpdateApplicationPortalOptions = struct {
    sign_in_options: ?SignInOptions,

    pub const json_field_names = .{
        .sign_in_options = "SignInOptions",
    };
};
