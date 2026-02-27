/// The container of quick response data.
pub const QuickResponseDataProvider = union(enum) {
    /// The content of the quick response.
    content: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
    };
};
