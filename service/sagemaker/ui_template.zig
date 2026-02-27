/// The Liquid template for the worker user interface.
pub const UiTemplate = struct {
    /// The content of the Liquid template for the worker user interface.
    content: []const u8,

    pub const json_field_names = .{
        .content = "Content",
    };
};
