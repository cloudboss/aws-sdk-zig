const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PresignedUrlAccessConfig = @import("presigned_url_access_config.zig").PresignedUrlAccessConfig;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const AuthorizedUrl = @import("authorized_url.zig").AuthorizedUrl;

pub const CreateHubContentPresignedUrlsInput = struct {
    /// Configuration settings for accessing the hub content, including end-user
    /// license agreement acceptance for gated models and expected S3 URL
    /// validation.
    access_config: ?PresignedUrlAccessConfig = null,

    /// The name of the hub content for which to generate presigned URLs. This
    /// identifies the specific model or content within the hub.
    hub_content_name: []const u8,

    /// The type of hub content to access. Valid values include `Model`, `Notebook`,
    /// and `ModelReference`.
    hub_content_type: HubContentType,

    /// The version of the hub content. If not specified, the latest version is
    /// used.
    hub_content_version: ?[]const u8 = null,

    /// The name or Amazon Resource Name (ARN) of the hub that contains the content.
    /// For public content, use `SageMakerPublicHub`.
    hub_name: []const u8,

    /// The maximum number of presigned URLs to return in the response. Default
    /// value is 100. Large models may contain hundreds of files, requiring
    /// pagination to retrieve all URLs.
    max_results: ?i32 = null,

    /// A token for pagination. Use this token to retrieve the next set of presigned
    /// URLs when the response is truncated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_config = "AccessConfig",
        .hub_content_name = "HubContentName",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const CreateHubContentPresignedUrlsOutput = struct {
    /// An array of authorized URL configurations, each containing a presigned URL
    /// and its corresponding local file path for proper file organization during
    /// download.
    authorized_url_configs: ?[]const AuthorizedUrl = null,

    /// A token for pagination. If present, indicates that more presigned URLs are
    /// available. Use this token in a subsequent request to retrieve additional
    /// URLs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorized_url_configs = "AuthorizedUrlConfigs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHubContentPresignedUrlsInput, options: CallOptions) !CreateHubContentPresignedUrlsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHubContentPresignedUrlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateHubContentPresignedUrls");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHubContentPresignedUrlsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateHubContentPresignedUrlsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
