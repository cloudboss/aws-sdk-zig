/// The properties that are applied when Google Analytics is being used as a
/// source.
pub const GoogleAnalyticsSourceProperties = struct {
    /// The object specified in the Google Analytics flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};
