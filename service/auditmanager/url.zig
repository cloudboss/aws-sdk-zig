/// Short for uniform resource locator. A URL is used as a unique identifier to
/// locate a
/// resource on the internet.
pub const URL = struct {
    /// The name or word that's used as a hyperlink to the URL.
    hyperlink_name: ?[]const u8 = null,

    /// The unique identifier for the internet resource.
    link: ?[]const u8 = null,

    pub const json_field_names = .{
        .hyperlink_name = "hyperlinkName",
        .link = "link",
    };
};
