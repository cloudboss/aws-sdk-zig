/// Contains the content of a memory record.
pub const MemoryContent = union(enum) {
    /// The text content of the memory record.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
