/// The container quick response content.
pub const QuickResponseContentProvider = union(enum) {
    /// The content of the quick response.
    content: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
    };
};
