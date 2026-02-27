/// Contains the cited text from the data source.
pub const Content = struct {
    /// The cited text from the data source.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
