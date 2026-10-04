/// Delta payload for a tool result metadata.
pub const HarnessToolResultMetadataBlockDelta = struct {
    /// The partial JSON-string fragment of the tool result metadata.
    metadata: []const u8,

    pub const json_field_names = .{
        .metadata = "metadata",
    };
};
