/// Provides help information on the registration type.
pub const RegistrationTypeDisplayHints = struct {
    /// The link to the document the display hint is associated with.
    documentation_link: ?[]const u8,

    /// The title of the document the display hint is associated with.
    documentation_title: ?[]const u8,

    /// A full description of the display hint.
    long_description: ?[]const u8,

    /// A short description of the display hint.
    short_description: ?[]const u8,

    /// The title of the display hint.
    title: []const u8,

    pub const json_field_names = .{
        .documentation_link = "DocumentationLink",
        .documentation_title = "DocumentationTitle",
        .long_description = "LongDescription",
        .short_description = "ShortDescription",
        .title = "Title",
    };
};
