const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QualificationRequest = @import("qualification_request.zig").QualificationRequest;

pub const ListQualificationRequestsInput = struct {
    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// The ID of the QualificationType.
    qualification_type_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .qualification_type_id = "QualificationTypeId",
    };
};

pub const ListQualificationRequestsOutput = struct {
    next_token: ?[]const u8 = null,

    /// The number of Qualification requests on this page in the filtered results
    /// list,
    /// equivalent to the number of Qualification requests being returned by this
    /// call.
    num_results: ?i32 = null,

    /// The Qualification request. The response includes one
    /// QualificationRequest element
    /// for each Qualification request returned
    /// by the query.
    qualification_requests: ?[]const QualificationRequest = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .num_results = "NumResults",
        .qualification_requests = "QualificationRequests",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQualificationRequestsInput, options: CallOptions) !ListQualificationRequestsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQualificationRequestsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ListQualificationRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQualificationRequestsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListQualificationRequestsOutput, body, allocator);
}
