const TeletextPageType = @import("teletext_page_type.zig").TeletextPageType;

/// Settings related to teletext captions. Set up teletext captions in the same
/// output as your video. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/teletext-output-captions.html.
pub const TeletextDestinationSettings = struct {
    /// Set pageNumber to the Teletext page number for the destination captions for
    /// this output. This value must be a three-digit hexadecimal string; strings
    /// ending in -FF are invalid. If you are passing through the entire set of
    /// Teletext data, do not use this field.
    page_number: ?[]const u8 = null,

    /// Specify the page types for this Teletext page. If you don't specify a value
    /// here, the service sets the page type to the default value Subtitle. If you
    /// pass through the entire set of Teletext data, don't use this field. When you
    /// pass through a set of Teletext pages, your output has the same page types as
    /// your input.
    page_types: ?[]const TeletextPageType = null,

    pub const json_field_names = .{
        .page_number = "PageNumber",
        .page_types = "PageTypes",
    };
};
