const ContactHandling = @import("contact_handling.zig").ContactHandling;

/// The configuration settings for the application.
pub const ApplicationConfig = struct {
    /// The contact handling configuration for the application.
    contact_handling: ?ContactHandling = null,

    pub const json_field_names = .{
        .contact_handling = "ContactHandling",
    };
};
