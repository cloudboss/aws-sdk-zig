const aws = @import("aws");

const TextPartType = @import("text_part_type.zig").TextPartType;

/// Describes text information objects containing fields that determine how text
/// part objects are composed.
pub const TextPartValue = struct {
    /// A short single line description of the link. Must be hyper-linked with the
    /// URL itself.
    ///
    /// Used for text parts with the type `URL`.
    display_text: ?[]const u8 = null,

    /// A map of locales to the text in that locale.
    text_by_locale: ?[]const aws.map.StringMapEntry = null,

    /// The type of text part. Determines the usage of all other fields and whether
    /// or not they're required.
    @"type": TextPartType,

    /// The URL itself.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_text = "displayText",
        .text_by_locale = "textByLocale",
        .@"type" = "type",
        .url = "url",
    };
};
