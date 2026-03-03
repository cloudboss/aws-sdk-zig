/// Provides the reason a registration was rejected.
pub const RegistrationDeniedReasonInformation = struct {
    /// The link to the document.
    documentation_link: ?[]const u8 = null,

    /// The title of the document.
    documentation_title: ?[]const u8 = null,

    /// A long description of the rejection reason.
    long_description: ?[]const u8 = null,

    /// The reason a registration was rejected.
    reason: []const u8,

    /// A short description of the rejection reason.
    short_description: []const u8,

    pub const json_field_names = .{
        .documentation_link = "DocumentationLink",
        .documentation_title = "DocumentationTitle",
        .long_description = "LongDescription",
        .reason = "Reason",
        .short_description = "ShortDescription",
    };
};
