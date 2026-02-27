/// Contains the content of a memory item.
pub const Content = union(enum) {
    /// The text content of the memory item.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
