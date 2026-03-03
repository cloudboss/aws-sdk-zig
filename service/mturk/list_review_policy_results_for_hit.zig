const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReviewPolicyLevel = @import("review_policy_level.zig").ReviewPolicyLevel;
const ReviewPolicy = @import("review_policy.zig").ReviewPolicy;
const ReviewReport = @import("review_report.zig").ReviewReport;

pub const ListReviewPolicyResultsForHITInput = struct {
    /// The unique identifier of the HIT to retrieve review results for.
    hit_id: []const u8,

    /// Limit the number of results returned.
    max_results: ?i32 = null,

    /// Pagination token
    next_token: ?[]const u8 = null,

    /// The Policy Level(s) to retrieve review results for - HIT or Assignment.
    /// If omitted, the default behavior is to retrieve all data for both policy
    /// levels.
    /// For a list of all the described policies, see Review Policies.
    policy_levels: ?[]const ReviewPolicyLevel = null,

    /// Specify if the operation should retrieve a list of the actions taken
    /// executing
    /// the Review Policies and their outcomes.
    retrieve_actions: ?bool = null,

    /// Specify if the operation should retrieve a list of the results computed by
    /// the Review Policies.
    retrieve_results: ?bool = null,

    pub const json_field_names = .{
        .hit_id = "HITId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .policy_levels = "PolicyLevels",
        .retrieve_actions = "RetrieveActions",
        .retrieve_results = "RetrieveResults",
    };
};

pub const ListReviewPolicyResultsForHITOutput = struct {
    /// The name of the Assignment-level Review Policy. This
    /// contains only the PolicyName element.
    assignment_review_policy: ?ReviewPolicy = null,

    /// Contains both ReviewResult and ReviewAction elements for an
    /// Assignment.
    assignment_review_report: ?ReviewReport = null,

    /// The HITId of the HIT for which results have been returned.
    hit_id: ?[]const u8 = null,

    /// The name of the HIT-level Review Policy. This contains only
    /// the PolicyName element.
    hit_review_policy: ?ReviewPolicy = null,

    /// Contains both ReviewResult and ReviewAction elements for a particular HIT.
    hit_review_report: ?ReviewReport = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_review_policy = "AssignmentReviewPolicy",
        .assignment_review_report = "AssignmentReviewReport",
        .hit_id = "HITId",
        .hit_review_policy = "HITReviewPolicy",
        .hit_review_report = "HITReviewReport",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReviewPolicyResultsForHITInput, options: Options) !ListReviewPolicyResultsForHITOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReviewPolicyResultsForHITInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ListReviewPolicyResultsForHIT");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReviewPolicyResultsForHITOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListReviewPolicyResultsForHITOutput, body, allocator);
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
