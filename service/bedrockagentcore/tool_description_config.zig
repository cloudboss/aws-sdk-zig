/// The tool description content.
pub const ToolDescriptionConfig = union(enum) {
    /// The tool description as inline text.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
