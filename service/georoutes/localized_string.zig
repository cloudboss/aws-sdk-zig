/// The localized string.
pub const LocalizedString = struct {
    /// A list of BCP 47 compliant language codes for the results to be rendered in.
    /// The request uses the regional default as the fallback if the requested
    /// language can't be provided.
    language: ?[]const u8 = null,

    /// The value of the localized string.
    value: []const u8,

    pub const json_field_names = .{
        .language = "Language",
        .value = "Value",
    };
};
