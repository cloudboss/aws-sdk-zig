const ContactHandlingScope = @import("contact_handling_scope.zig").ContactHandlingScope;

/// The contact handling configuration for the application.
pub const ContactHandling = struct {
    /// Indicates whether the application refreshes for each contact or refreshes
    /// only with each new browser session.
    scope: ?ContactHandlingScope = null,

    pub const json_field_names = .{
        .scope = "Scope",
    };
};
