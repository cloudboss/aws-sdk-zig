/// A imported variant item's source.
pub const VariantImportItemSource = struct {
    /// The source file's location in Amazon S3.
    source: []const u8,

    pub const json_field_names = .{
        .source = "source",
    };
};
