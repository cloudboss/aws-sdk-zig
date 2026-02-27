/// Structure for expressing the query language version.
pub const QueryLanguageVersion = struct {
    /// The version of the query language.
    version: []const u8,

    pub const json_field_names = .{
        .version = "version",
    };
};
