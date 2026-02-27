/// A retrieve and generate output event.
pub const RetrieveAndGenerateOutputEvent = struct {
    /// A text response.
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
