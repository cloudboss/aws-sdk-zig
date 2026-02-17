const ExpressionType = @import("expression_type.zig").ExpressionType;
const InputSerialization = @import("input_serialization.zig").InputSerialization;
const OutputSerialization = @import("output_serialization.zig").OutputSerialization;

/// Amazon S3 Select is no longer available to new customers. Existing customers
/// of Amazon S3 Select can
/// continue to use the feature as usual. [Learn
/// more](http://aws.amazon.com/blogs/storage/how-to-optimize-querying-your-data-in-amazon-s3/)
///
/// Describes the parameters for Select job types.
///
/// Learn [How to
/// optimize querying your data in Amazon
/// S3](http://aws.amazon.com/blogs/storage/how-to-optimize-querying-your-data-in-amazon-s3/) using [Amazon Athena](https://docs.aws.amazon.com/athena/latest/ug/what-is.html), [S3 Object Lambda](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transforming-objects.html), or client-side
/// filtering.
pub const SelectParameters = struct {
    /// Amazon S3 Select is no longer available to new customers. Existing customers
    /// of Amazon S3 Select can
    /// continue to use the feature as usual. [Learn
    /// more](http://aws.amazon.com/blogs/storage/how-to-optimize-querying-your-data-in-amazon-s3/)
    ///
    /// The expression that is used to query the object.
    expression: []const u8,

    /// The type of the provided expression (for example, SQL).
    expression_type: ExpressionType,

    /// Describes the serialization format of the object.
    input_serialization: InputSerialization,

    /// Describes how the results of the Select job are serialized.
    output_serialization: OutputSerialization,
};
