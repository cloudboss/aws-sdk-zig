/// Information about a single NDI® sender, including its name.
pub const NdiSourceInfo = struct {
    /// The name of the upstream NDI sender.
    source_name: []const u8,

    pub const json_field_names = .{
        .source_name = "SourceName",
    };
};
