const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const MetadataTableConfiguration = @import("metadata_table_configuration.zig").MetadataTableConfiguration;
const serde = @import("serde.zig");

/// **Important:**
///
/// We recommend that you create your S3 Metadata configurations by using the V2
/// [CreateBucketMetadataConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucketMetadataConfiguration.html) API operation. We no longer recommend using the V1
/// `CreateBucketMetadataTableConfiguration` API operation.
///
/// If you created your S3 Metadata configuration before July 15, 2025, we
/// recommend that you delete
/// and re-create your configuration by using
/// [CreateBucketMetadataConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucketMetadataConfiguration.html) so that you can expire journal table records and create
/// a live inventory table.
///
/// Creates a V1 S3 Metadata configuration for a general purpose bucket. For
/// more information, see
/// [Accelerating
/// data discovery with S3
/// Metadata](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metadata-tables-overview.html) in the *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// To use this operation, you must have the following permissions. For more
/// information, see
/// [Setting up permissions for configuring metadata
/// tables](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metadata-tables-permissions.html) in the
/// *Amazon S3 User Guide*.
///
/// If you want to encrypt your metadata tables with server-side encryption with
/// Key Management Service
/// (KMS) keys (SSE-KMS), you need additional permissions. For more
/// information, see [
/// Setting up permissions for configuring metadata
/// tables](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metadata-tables-permissions.html) in the
/// *Amazon S3 User Guide*.
///
/// If you also want to integrate your table bucket with Amazon Web Services
/// analytics services so that you can
/// query your metadata table, you need additional permissions. For more
/// information, see [ Integrating
/// Amazon S3 Tables with Amazon Web Services analytics
/// services](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-integrating-aws.html) in the
/// *Amazon S3 User Guide*.
///
/// * `s3:CreateBucketMetadataTableConfiguration`
///
/// * `s3tables:CreateNamespace`
///
/// * `s3tables:GetTable`
///
/// * `s3tables:CreateTable`
///
/// * `s3tables:PutTablePolicy`
///
/// The following operations are related to
/// `CreateBucketMetadataTableConfiguration`:
///
/// *
///   [DeleteBucketMetadataTableConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketMetadataTableConfiguration.html)
///
/// *
///   [GetBucketMetadataTableConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketMetadataTableConfiguration.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const CreateBucketMetadataTableConfigurationInput = struct {
    /// The general purpose bucket that you want to create the metadata table
    /// configuration for.
    bucket: []const u8,

    /// The checksum algorithm to use with your metadata table configuration.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The `Content-MD5` header for the metadata table configuration.
    content_md5: ?[]const u8 = null,

    /// The expected owner of the general purpose bucket that corresponds to your
    /// metadata table configuration.
    expected_bucket_owner: ?[]const u8 = null,

    /// The contents of your metadata table configuration.
    metadata_table_configuration: MetadataTableConfiguration,
};

pub const CreateBucketMetadataTableConfigurationOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateBucketMetadataTableConfigurationOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateBucketMetadataTableConfigurationInput, options: Options) !CreateBucketMetadataTableConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateBucketMetadataTableConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "metadataTable");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<MetadataTableConfiguration xmlns=" ++ &[_]u8{0x22} ++ "http://s3.amazonaws.com/doc/2006-03-01/" ++ &[_]u8{0x22} ++ ">");
    try serde.serializeMetadataTableConfiguration(alloc, &body_buf, input.metadata_table_configuration);
    try body_buf.appendSlice(alloc, "</MetadataTableConfiguration>");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.checksum_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-sdk-checksum-algorithm", @tagName(v));
    }
    if (input.content_md5) |v| {
        try request.headers.put(alloc, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateBucketMetadataTableConfigurationOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateBucketMetadataTableConfigurationOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .access_denied = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .bucket_already_exists = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .bucket_already_owned_by_you = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .encryption_type_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .idempotency_parameter_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .invalid_object_state = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .invalid_request = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .invalid_write_offset = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .no_such_bucket = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .no_such_key = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .no_such_upload = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .not_found = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .object_already_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .object_not_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .too_many_parts = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
