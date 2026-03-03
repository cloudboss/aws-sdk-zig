/// Source files for a sequence.
pub const SourceFiles = struct {
    /// The location of the first file in Amazon S3.
    source_1: []const u8,

    /// The location of the second file in Amazon S3.
    source_2: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_1 = "source1",
        .source_2 = "source2",
    };
};
