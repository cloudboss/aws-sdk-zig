/// Details about a sequence.
pub const SequenceInformation = struct {
    /// The sequence's alignment setting.
    alignment: ?[]const u8,

    /// Where the sequence originated.
    generated_from: ?[]const u8,

    /// The sequence's total base count.
    total_base_count: ?i64,

    /// The sequence's total read count.
    total_read_count: ?i64,

    pub const json_field_names = .{
        .alignment = "alignment",
        .generated_from = "generatedFrom",
        .total_base_count = "totalBaseCount",
        .total_read_count = "totalReadCount",
    };
};
