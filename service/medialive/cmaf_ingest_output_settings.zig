/// Cmaf Ingest Output Settings
pub const CmafIngestOutputSettings = struct {
    /// String concatenated to the end of the destination filename. Required for
    /// multiple outputs of the same type.
    name_modifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .name_modifier = "NameModifier",
    };
};
