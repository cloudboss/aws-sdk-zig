/// A URL-based descriptor source that identifies where descriptor content is
/// retrieved from.
pub const DescriptorSourceFromUrl = struct {
    /// The URL from which the descriptor content is retrieved.
    url: []const u8,

    pub const json_field_names = .{
        .url = "url",
    };
};
