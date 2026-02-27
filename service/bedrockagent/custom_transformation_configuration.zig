const IntermediateStorage = @import("intermediate_storage.zig").IntermediateStorage;
const Transformation = @import("transformation.zig").Transformation;

/// Settings for customizing steps in the data source content ingestion
/// pipeline.
///
/// You can configure the data source to process documents with a Lambda
/// function after they are parsed and converted into chunks. When you add a
/// post-chunking transformation, the service stores chunked documents in an S3
/// bucket and invokes a Lambda function to process them.
///
/// To process chunked documents with a Lambda function, define an S3 bucket
/// path for input and output objects, and a transformation that specifies the
/// Lambda function to invoke. You can use the Lambda function to customize how
/// chunks are split, and the metadata for each chunk.
pub const CustomTransformationConfiguration = struct {
    /// An S3 bucket path for input and output objects.
    intermediate_storage: IntermediateStorage,

    /// A Lambda function that processes documents.
    transformations: []const Transformation,

    pub const json_field_names = .{
        .intermediate_storage = "intermediateStorage",
        .transformations = "transformations",
    };
};
