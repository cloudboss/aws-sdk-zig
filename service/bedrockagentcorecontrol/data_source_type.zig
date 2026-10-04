const InlineExamplesSource = @import("inline_examples_source.zig").InlineExamplesSource;
const S3Source = @import("s3_source.zig").S3Source;

/// Source of examples to add to the dataset.
pub const DataSourceType = union(enum) {
    /// Inline examples provided directly in the request body.
    inline_examples: ?InlineExamplesSource,
    /// Amazon S3 URI pointing to a JSONL file in the customer's bucket.
    s_3_source: ?S3Source,

    pub const json_field_names = .{
        .inline_examples = "inlineExamples",
        .s_3_source = "s3Source",
    };
};
