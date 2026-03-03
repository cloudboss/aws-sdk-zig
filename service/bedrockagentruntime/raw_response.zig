/// Contains the raw output from the foundation model.
pub const RawResponse = struct {
    /// The foundation model's raw output content.
    content: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
    };
};
