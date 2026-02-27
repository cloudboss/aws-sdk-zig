const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExpressionType = @import("expression_type.zig").ExpressionType;
const InputSerialization = @import("input_serialization.zig").InputSerialization;
const OutputSerialization = @import("output_serialization.zig").OutputSerialization;
const RequestProgress = @import("request_progress.zig").RequestProgress;
const ScanRange = @import("scan_range.zig").ScanRange;
const SelectObjectContentEventStream = @import("select_object_content_event_stream.zig").SelectObjectContentEventStream;
const serde = @import("serde.zig");

pub const SelectObjectContentInput = struct {
    /// The S3 bucket.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The expression that is used to query the object.
    expression: []const u8,

    /// The type of the provided expression (for example, SQL).
    expression_type: ExpressionType,

    /// Describes the format of the data in the object that is being queried.
    input_serialization: InputSerialization,

    /// The object key.
    key: []const u8,

    /// Describes the format of the data that you want Amazon S3 to return in
    /// response.
    output_serialization: OutputSerialization,

    /// Specifies if periodic request progress information should be enabled.
    request_progress: ?RequestProgress = null,

    /// Specifies the byte range of the object to get the records from. A record is
    /// processed when its first
    /// byte is contained by the range. This parameter is optional, but when
    /// specified, it must not be empty.
    /// See RFC 2616, Section 14.35.1 about how to specify the start and end of the
    /// range.
    ///
    /// `ScanRange`may be used in the following ways:
    ///
    /// * `50100`
    /// - process only the records starting between the bytes 50 and 100 (inclusive,
    /// counting from
    /// zero)
    ///
    /// * `50` - process only the
    /// records starting after the byte 50
    ///
    /// * `50` - process only the
    /// records within the last 50 bytes of the file.
    scan_range: ?ScanRange = null,

    /// The server-side encryption (SSE) algorithm used to encrypt the object. This
    /// parameter is needed only when the object was created
    /// using a checksum algorithm. For more information,
    /// see [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    sse_customer_algorithm: ?[]const u8 = null,

    /// The server-side encryption (SSE) customer managed key. This parameter is
    /// needed only when the object was created using a checksum algorithm.
    /// For more information, see
    /// [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    sse_customer_key: ?[]const u8 = null,

    /// The MD5 server-side encryption (SSE) customer managed key. This parameter is
    /// needed only when the object was created using a checksum
    /// algorithm. For more information,
    /// see [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    sse_customer_key_md5: ?[]const u8 = null,
};

pub const SelectObjectContentOutput = struct {
    /// The array of results.
    payload: ?SelectObjectContentEventStream = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SelectObjectContentInput, options: Options) !SelectObjectContentOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
