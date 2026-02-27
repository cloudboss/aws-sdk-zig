const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BucketAccessLogConfig = @import("bucket_access_log_config.zig").BucketAccessLogConfig;
const AccessRules = @import("access_rules.zig").AccessRules;
const BucketCorsConfig = @import("bucket_cors_config.zig").BucketCorsConfig;
const Bucket = @import("bucket.zig").Bucket;
const Operation = @import("operation.zig").Operation;

pub const UpdateBucketInput = struct {
    /// An object that describes the access log configuration for the bucket.
    access_log_config: ?BucketAccessLogConfig = null,

    /// An object that sets the public accessibility of objects in the specified
    /// bucket.
    access_rules: ?AccessRules = null,

    /// The name of the bucket to update.
    bucket_name: []const u8,

    /// Sets the cross-origin resource sharing (CORS) configuration for your bucket.
    /// If a CORS configuration exists, it is replaced with the specified
    /// configuration. For AWS CLI operations, this parameter can also be passed as
    /// a file. For more information, see [Configuring cross-origin resource sharing
    /// (CORS)](https://docs.aws.amazon.com/lightsail/latest/userguide/configure-cors.html).
    ///
    /// CORS information is only returned in a response when you update the CORS
    /// policy.
    cors: ?BucketCorsConfig = null,

    /// An array of strings to specify the Amazon Web Services account IDs that can
    /// access the
    /// bucket.
    ///
    /// You can give a maximum of 10 Amazon Web Services accounts access to a
    /// bucket.
    readonly_access_accounts: ?[]const []const u8 = null,

    /// Specifies whether to enable or suspend versioning of objects in the bucket.
    ///
    /// The following options can be specified:
    ///
    /// * `Enabled` - Enables versioning of objects in the specified bucket.
    ///
    /// * `Suspended` - Suspends versioning of objects in the specified bucket.
    /// Existing object versions are retained.
    versioning: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_log_config = "accessLogConfig",
        .access_rules = "accessRules",
        .bucket_name = "bucketName",
        .cors = "cors",
        .readonly_access_accounts = "readonlyAccessAccounts",
        .versioning = "versioning",
    };
};

pub const UpdateBucketOutput = struct {
    /// An object that describes the bucket that is updated.
    bucket: ?Bucket = null,

    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .operations = "operations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBucketInput, options: Options) !UpdateBucketOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.UpdateBucket");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateBucketOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateBucketOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
