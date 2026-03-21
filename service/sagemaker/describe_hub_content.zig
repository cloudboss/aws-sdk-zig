const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const HubContentDependency = @import("hub_content_dependency.zig").HubContentDependency;
const HubContentStatus = @import("hub_content_status.zig").HubContentStatus;
const HubContentSupportStatus = @import("hub_content_support_status.zig").HubContentSupportStatus;

pub const DescribeHubContentInput = struct {
    /// The name of the content to describe.
    hub_content_name: []const u8,

    /// The type of content in the hub.
    hub_content_type: HubContentType,

    /// The version of the content to describe.
    hub_content_version: ?[]const u8 = null,

    /// The name of the hub that contains the content to describe.
    hub_name: []const u8,

    pub const json_field_names = .{
        .hub_content_name = "HubContentName",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
    };
};

pub const DescribeHubContentOutput = struct {
    /// The date and time that hub content was created.
    creation_time: i64,

    /// The document schema version for the hub content.
    document_schema_version: []const u8,

    /// The failure reason if importing hub content failed.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hub that contains the content.
    hub_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the hub content.
    hub_content_arn: []const u8,

    /// The location of any dependencies that the hub content has, such as scripts,
    /// model artifacts, datasets, or notebooks.
    hub_content_dependencies: ?[]const HubContentDependency = null,

    /// A description of the hub content.
    hub_content_description: ?[]const u8 = null,

    /// The display name of the hub content.
    hub_content_display_name: ?[]const u8 = null,

    /// The hub content document that describes information about the hub content
    /// such as type, associated containers, scripts, and more.
    hub_content_document: []const u8,

    /// A string that provides a description of the hub content. This string can
    /// include links, tables, and standard markdown formating.
    hub_content_markdown: ?[]const u8 = null,

    /// The name of the hub content.
    hub_content_name: []const u8,

    /// The searchable keywords for the hub content.
    hub_content_search_keywords: ?[]const []const u8 = null,

    /// The status of the hub content.
    hub_content_status: HubContentStatus,

    /// The type of hub content.
    hub_content_type: HubContentType,

    /// The version of the hub content.
    hub_content_version: []const u8,

    /// The name of the hub that contains the content.
    hub_name: []const u8,

    /// The last modified time of the hub content.
    last_modified_time: ?i64 = null,

    /// The minimum version of the hub content.
    reference_min_version: ?[]const u8 = null,

    /// The ARN of the public hub content.
    sage_maker_public_hub_content_arn: ?[]const u8 = null,

    /// The support status of the hub content.
    support_status: ?HubContentSupportStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .document_schema_version = "DocumentSchemaVersion",
        .failure_reason = "FailureReason",
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
        .hub_content_dependencies = "HubContentDependencies",
        .hub_content_description = "HubContentDescription",
        .hub_content_display_name = "HubContentDisplayName",
        .hub_content_document = "HubContentDocument",
        .hub_content_markdown = "HubContentMarkdown",
        .hub_content_name = "HubContentName",
        .hub_content_search_keywords = "HubContentSearchKeywords",
        .hub_content_status = "HubContentStatus",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .last_modified_time = "LastModifiedTime",
        .reference_min_version = "ReferenceMinVersion",
        .sage_maker_public_hub_content_arn = "SageMakerPublicHubContentArn",
        .support_status = "SupportStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHubContentInput, options: CallOptions) !DescribeHubContentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHubContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeHubContent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHubContentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeHubContentOutput, body, allocator);
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
