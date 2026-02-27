const ContactPreference = @import("contact_preference.zig").ContactPreference;

/// Object that defines users preferred methods of engagement.
pub const EngagementPreferences = struct {
    /// A list of email-related contact preferences
    email: ?[]const ContactPreference,

    /// A list of phone-related contact preferences
    phone: ?[]const ContactPreference,

    pub const json_field_names = .{
        .email = "Email",
        .phone = "Phone",
    };
};
