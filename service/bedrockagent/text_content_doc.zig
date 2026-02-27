/// Contains information about content defined inline in text.
pub const TextContentDoc = struct {
    /// The text of the content.
    data: []const u8,

    pub const json_field_names = .{
        .data = "data",
    };
};
