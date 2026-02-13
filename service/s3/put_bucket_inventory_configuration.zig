const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InventoryConfiguration = @import("inventory_configuration.zig").InventoryConfiguration;
const serde = @import("serde.zig");

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// This implementation of the `PUT` action adds an S3 Inventory configuration
/// (identified by
/// the inventory ID) to the bucket. You can have up to 1,000 inventory
/// configurations per bucket.
///
/// Amazon S3 inventory generates inventories of the objects in the bucket on a
/// daily or weekly basis, and
/// the results are published to a flat file. The bucket that is inventoried is
/// called the
/// *source* bucket, and the bucket where the inventory flat file is stored is
/// called
/// the *destination* bucket. The *destination* bucket must be in the
/// same Amazon Web Services Region as the *source* bucket.
///
/// When you configure an inventory for a *source* bucket, you specify the
/// *destination* bucket where you want the inventory to be stored, and whether
/// to
/// generate the inventory daily or weekly. You can also configure what object
/// metadata to include and
/// whether to inventory all object versions or only current versions. For more
/// information, see [Amazon S3
/// Inventory](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-inventory.html) in the
/// Amazon S3 User Guide.
///
/// **Important:**
///
/// You must create a bucket policy on the *destination* bucket to grant
/// permissions to Amazon S3 to write objects to the bucket in the defined
/// location. For an example policy, see
/// [ Granting
/// Permissions for Amazon S3 Inventory and Storage Class
/// Analysis](https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html#example-bucket-policies-use-case-9).
///
/// **Permissions**
///
/// To use this operation, you must have permission to perform the
/// `s3:PutInventoryConfiguration` action. The bucket owner has this permission
/// by
/// default and can grant this permission to others.
///
/// The `s3:PutInventoryConfiguration` permission allows a user to create an [S3
/// Inventory](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-inventory.html)
/// report that includes all object metadata fields available and to specify the
/// destination bucket to
/// store the inventory. A user with read access to objects in the destination
/// bucket can also access
/// all object metadata fields that are available in the inventory report.
///
/// To restrict access to an inventory report, see [Restricting access to an
/// Amazon S3 Inventory
/// report](https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html#example-bucket-policies-use-case-10) in the
/// *Amazon S3 User Guide*. For more information about the metadata fields
/// available
/// in S3 Inventory, see [Amazon S3 Inventory
/// lists](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-inventory.html#storage-inventory-contents) in the *Amazon S3 User Guide*. For more information about
/// permissions, see [Permissions related to bucket subresource
/// operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources) and [Identity and access management in
/// Amazon
/// S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html) in the *Amazon S3 User Guide*.
///
/// `PutBucketInventoryConfiguration` has the following special errors:
///
/// **HTTP 400 Bad Request Error**
///
/// *Code:* InvalidArgument
///
/// *Cause:* Invalid Argument
///
/// **HTTP 400 Bad Request Error**
///
/// *Code:* TooManyConfigurations
///
/// *Cause:* You are attempting to create a new configuration but have already
/// reached the 1,000-configuration limit.
///
/// **HTTP 403 Forbidden Error**
///
/// *Cause:* You are not the owner of the specified bucket, or you do not have
/// the `s3:PutInventoryConfiguration` bucket permission to set the
/// configuration on the
/// bucket.
///
/// The following operations are related to `PutBucketInventoryConfiguration`:
///
/// *
///   [GetBucketInventoryConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketInventoryConfiguration.html)
///
/// *
///   [DeleteBucketInventoryConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketInventoryConfiguration.html)
///
/// *
///   [ListBucketInventoryConfigurations](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBucketInventoryConfigurations.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const PutBucketInventoryConfigurationInput = struct {
    /// The name of the bucket where the inventory configuration will be stored.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The ID used to identify the inventory configuration.
    id: []const u8,

    /// Specifies the inventory configuration.
    inventory_configuration: InventoryConfiguration,
};

pub const PutBucketInventoryConfigurationOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PutBucketInventoryConfigurationOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutBucketInventoryConfigurationInput, options: Options) !PutBucketInventoryConfigurationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutBucketInventoryConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "inventory");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "id=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(alloc, "<InventoryConfiguration xmlns=" ++ &[_]u8{0x22} ++ "http://s3.amazonaws.com/doc/2006-03-01/" ++ &[_]u8{0x22} ++ ">");
    try serde.serializeInventoryConfiguration(alloc, &body_buf, input.inventory_configuration);
    try body_buf.appendSlice(alloc, "</InventoryConfiguration>");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutBucketInventoryConfigurationOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketInventoryConfigurationOutput = .{};

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
