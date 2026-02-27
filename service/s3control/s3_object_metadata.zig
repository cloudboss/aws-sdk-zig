const aws = @import("aws");

const S3SSEAlgorithm = @import("s3_sse_algorithm.zig").S3SSEAlgorithm;

pub const S3ObjectMetadata = struct {
    cache_control: ?[]const u8,

    content_disposition: ?[]const u8,

    content_encoding: ?[]const u8,

    content_language: ?[]const u8,

    /// *This member has been deprecated.*
    content_length: ?i64,

    /// *This member has been deprecated.*
    content_md5: ?[]const u8,

    content_type: ?[]const u8,

    http_expires_date: ?i64,

    /// *This member has been deprecated.*
    requester_charged: bool = false,

    /// The server-side encryption algorithm used when storing objects in Amazon S3.
    ///
    /// **Directory buckets ** - For directory buckets, there are only two supported
    /// options for server-side encryption: server-side encryption with Amazon S3
    /// managed keys (SSE-S3) (`AES256`) and server-side encryption with KMS keys
    /// (SSE-KMS) (`KMS`). For more
    /// information, see [Protecting data with server-side
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-serv-side-encryption.html) in the *Amazon S3 User Guide*. For [the Copy operation in Batch Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-objects-Batch-Ops), see [S3CopyObjectOperation](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_S3CopyObjectOperation.html).
    sse_algorithm: ?S3SSEAlgorithm,

    user_metadata: ?[]const aws.map.StringMapEntry,
};
