const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceType = @import("resource_type.zig").ResourceType;
const EngagementResourceAssociationSummary = @import("engagement_resource_association_summary.zig").EngagementResourceAssociationSummary;

pub const ListEngagementResourceAssociationsInput = struct {
    /// Specifies the catalog in which to search for engagement-resource
    /// associations. Valid Values: "AWS" or "Sandbox"
    ///
    /// * `AWS` for production environments.
    /// * `Sandbox` for testing and development purposes.
    catalog: []const u8,

    /// Filters the response to include only snapshots of resources owned by the
    /// specified AWS account ID. Use this when you want to find associations
    /// related to resources owned by a particular account.
    created_by: ?[]const u8 = null,

    /// Filters the results to include only associations related to the specified
    /// engagement. Use this when you want to find all resources associated with a
    /// specific engagement.
    engagement_identifier: ?[]const u8 = null,

    /// Limits the number of results returned in a single call. Use this to control
    /// the number of results returned, especially useful for pagination.
    max_results: ?i32 = null,

    /// A token used for pagination of results. Include this token in subsequent
    /// requests to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// Filters the results to include only associations with the specified
    /// resource. Varies depending on the resource type. Use this when you want to
    /// find all engagements associated with a specific resource.
    resource_identifier: ?[]const u8 = null,

    /// Filters the results to include only associations with resources of the
    /// specified type.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .created_by = "CreatedBy",
        .engagement_identifier = "EngagementIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
    };
};

pub const ListEngagementResourceAssociationsOutput = struct {
    /// A list of engagement-resource association summaries.
    engagement_resource_association_summaries: ?[]const EngagementResourceAssociationSummary = null,

    /// A token to retrieve the next set of results. Use this token in a subsequent
    /// request to retrieve additional results if the response was truncated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .engagement_resource_association_summaries = "EngagementResourceAssociationSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementResourceAssociationsInput, options: CallOptions) !ListEngagementResourceAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentral");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementResourceAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagementResourceAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementResourceAssociationsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEngagementResourceAssociationsOutput, body, allocator);
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
