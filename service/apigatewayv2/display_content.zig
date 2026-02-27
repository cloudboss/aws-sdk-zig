/// The content of the product page.
pub const DisplayContent = struct {
    /// The body.
    body: []const u8,

    /// The title.
    title: []const u8,

    pub const json_field_names = .{
        .body = "Body",
        .title = "Title",
    };
};
