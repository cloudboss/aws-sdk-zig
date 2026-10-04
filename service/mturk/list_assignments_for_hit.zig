const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssignmentsForHITInput, options: CallOptions) !ListAssignmentsForHITOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mturk-requester", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssignmentsForHITInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mturk-requester", "MTurk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
