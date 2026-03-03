const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;
const EngagementSort = @import("engagement_sort.zig").EngagementSort;
const EngagementSummary = @import("engagement_summary.zig").EngagementSummary;

pub const ListEngagementsInput = struct {
    /// Specifies the catalog related to the request.
    catalog: []const u8,

    /// Filters engagements to include only those containing the specified context
    /// types, such as "CustomerProject" or "Lead". Use this to find engagements
    /// that have specific types of contextual information associated with them.
    context_types: ?[]const EngagementContextType = null,

    /// A list of AWS account IDs. When specified, the response includes engagements
    /// created by these accounts. This filter is useful for finding engagements
    /// created by specific team members.
    created_by: ?[]const []const u8 = null,

    /// An array of strings representing engagement identifiers to retrieve.
    engagement_identifier: ?[]const []const u8 = null,

    /// Filters engagements to exclude those containing the specified context types.
    /// Use this to find engagements that do not have certain types of contextual
    /// information, helping to narrow results based on context exclusion criteria.
    exclude_context_types: ?[]const EngagementContextType = null,

    /// An array of strings representing AWS Account IDs. Use this to exclude
    /// engagements created by specific users.
    exclude_created_by: ?[]const []const u8 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// The token for the next set of results. This value is returned from a
    /// previous call.
    next_token: ?[]const u8 = null,

    sort: ?EngagementSort = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .context_types = "ContextTypes",
        .created_by = "CreatedBy",
        .engagement_identifier = "EngagementIdentifier",
        .exclude_context_types = "ExcludeContextTypes",
        .exclude_created_by = "ExcludeCreatedBy",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
    };
};

pub const ListEngagementsOutput = struct {
    /// An array of engagement summary objects.
    engagement_summary_list: ?[]const EngagementSummary = null,

    /// The token to retrieve the next set of results. This field will be null if
    /// there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engagement_summary_list = "EngagementSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementsInput, options: CallOptions) !ListEngagementsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEngagementsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
