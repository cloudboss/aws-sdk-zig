const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReviewableHITStatus = @import("reviewable_hit_status.zig").ReviewableHITStatus;
const HIT = @import("hit.zig").HIT;

pub const ListReviewableHITsInput = struct {
    /// The ID of the HIT type of the HITs to consider for the query.
    /// If not specified, all HITs for the Reviewer are considered
    hit_type_id: ?[]const u8 = null,

    /// Limit the number of results returned.
    max_results: ?i32 = null,

    /// Pagination Token
    next_token: ?[]const u8 = null,

    /// Can be either `Reviewable` or `Reviewing`.
    /// Reviewable is the default value.
    status: ?ReviewableHITStatus = null,

    pub const json_field_names = .{
        .hit_type_id = "HITTypeId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListReviewableHITsOutput = struct {
    /// The list of HIT elements returned by the query.
    hi_ts: ?[]const HIT = null,

    next_token: ?[]const u8 = null,

    /// The number of HITs on this page in the filtered results
    /// list, equivalent to the number of HITs being returned by this call.
    num_results: ?i32 = null,

    pub const json_field_names = .{
        .hi_ts = "HITs",
        .next_token = "NextToken",
        .num_results = "NumResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReviewableHITsInput, options: CallOptions) !ListReviewableHITsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReviewableHITsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ListReviewableHITs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReviewableHITsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListReviewableHITsOutput, body, allocator);
}
