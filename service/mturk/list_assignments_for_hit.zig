const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AssignmentStatus = @import("assignment_status.zig").AssignmentStatus;
const Assignment = @import("assignment.zig").Assignment;

pub const ListAssignmentsForHITInput = struct {
    /// The status of the assignments to return: Submitted | Approved
    /// | Rejected
    assignment_statuses: ?[]const AssignmentStatus = null,

    /// The ID of the HIT.
    hit_id: []const u8,

    max_results: ?i32 = null,

    /// Pagination token
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_statuses = "AssignmentStatuses",
        .hit_id = "HITId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAssignmentsForHITOutput = struct {
    /// The collection of Assignment data structures returned by
    /// this call.
    assignments: ?[]const Assignment = null,

    next_token: ?[]const u8 = null,

    /// The number of assignments on the page in the filtered
    /// results list, equivalent to the number of assignments returned by
    /// this call.
    num_results: ?i32 = null,

    pub const json_field_names = .{
        .assignments = "Assignments",
        .next_token = "NextToken",
        .num_results = "NumResults",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssignmentsForHITInput, options: Options) !ListAssignmentsForHITOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mturk");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssignmentsForHITInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk", "MTurk", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ListAssignmentsForHIT");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssignmentsForHITOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAssignmentsForHITOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "RequestError")) {
        return .{ .arena = arena, .kind = .{ .request_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFault")) {
        return .{ .arena = arena, .kind = .{ .service_fault = .{
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
