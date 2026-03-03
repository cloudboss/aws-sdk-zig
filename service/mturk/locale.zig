/// The Locale data structure represents a geographical region or location.
pub const Locale = struct {
    /// The country of the locale. Must be a valid ISO 3166 country
    /// code. For example, the code US refers to the United States of
    /// America.
    country: []const u8,

    /// The state or subdivision of the locale. A valid ISO 3166-2
    /// subdivision code. For example, the code WA refers to the state of
    /// Washington.
    subdivision: ?[]const u8 = null,

    pub const json_field_names = .{
        .country = "Country",
        .subdivision = "Subdivision",
    };
};
