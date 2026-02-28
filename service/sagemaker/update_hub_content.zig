const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const HubContentSupportStatus = @import("hub_content_support_status.zig").HubContentSupportStatus;

pub const UpdateHubContentInput = struct {
    /// The description of the hub content.
    hub_content_description: ?[]const u8 = null,

    /// The display name of the hub content.
    hub_content_display_name: ?[]const u8 = null,

    /// A string that provides a description of the hub content. This string can
    /// include links, tables, and standard markdown formatting.
    hub_content_markdown: ?[]const u8 = null,

    /// The name of the hub content resource that you want to update.
    hub_content_name: []const u8,

    /// The searchable keywords of the hub content.
    hub_content_search_keywords: ?[]const []const u8 = null,

    /// The content type of the resource that you want to update. Only specify a
    /// `Model` or `Notebook` resource for this API. To update a `ModelReference`,
    /// use the `UpdateHubContentReference` API instead.
    hub_content_type: HubContentType,

    /// The hub content version that you want to update. For example, if you have
    /// two versions of a resource in your hub, you can update the second version.
    hub_content_version: []const u8,

    /// The name of the SageMaker hub that contains the hub content you want to
    /// update. You can optionally use the hub ARN instead.
    hub_name: []const u8,

    /// Indicates the current status of the hub content resource.
    support_status: ?HubContentSupportStatus = null,

    pub const json_field_names = .{
        .hub_content_description = "HubContentDescription",
        .hub_content_display_name = "HubContentDisplayName",
        .hub_content_markdown = "HubContentMarkdown",
        .hub_content_name = "HubContentName",
        .hub_content_search_keywords = "HubContentSearchKeywords",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .support_status = "SupportStatus",
    };
};

pub const UpdateHubContentOutput = struct {
    /// The ARN of the private model hub that contains the updated hub content.
    hub_arn: []const u8,

    /// The ARN of the hub content resource that was updated.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHubContentInput, options: Options) !UpdateHubContentOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateHubContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.UpdateHubContent");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateHubContentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateHubContentOutput, body, alloc);
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
