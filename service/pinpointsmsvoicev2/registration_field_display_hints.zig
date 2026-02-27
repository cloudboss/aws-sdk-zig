const SelectOptionDescription = @import("select_option_description.zig").SelectOptionDescription;

/// Provides help information on the registration field.
pub const RegistrationFieldDisplayHints = struct {
    /// The link to the document the display hint is associated with.
    documentation_link: ?[]const u8,

    /// The title of the document the display hint is associated with.
    documentation_title: ?[]const u8,

    /// Example text of what the value of a field should contain.
    example_text_value: ?[]const u8,

    /// A full description of the display hint.
    long_description: ?[]const u8,

    /// An array of SelectOptionDescription objects.
    select_option_descriptions: ?[]const SelectOptionDescription,

    /// A short description of the display hint.
    short_description: []const u8,

    /// The validation rules for the text field.
    text_validation_description: ?[]const u8,

    /// The title of the display hint.
    title: []const u8,

    pub const json_field_names = .{
        .documentation_link = "DocumentationLink",
        .documentation_title = "DocumentationTitle",
        .example_text_value = "ExampleTextValue",
        .long_description = "LongDescription",
        .select_option_descriptions = "SelectOptionDescriptions",
        .short_description = "ShortDescription",
        .text_validation_description = "TextValidationDescription",
        .title = "Title",
    };
};
