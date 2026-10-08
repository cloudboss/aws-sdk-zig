const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ApproveAssignmentInput = struct {
    /// The ID of the assignment. The assignment must correspond to a HIT created by
    /// the Requester.
    assignment_id: []const u8,

    /// A flag indicating that an assignment should be approved even if it was
    /// previously rejected. Defaults to `False`.
    override_rejection: ?bool = null,

    /// A message for the Worker, which the Worker can see in the Status section of
    /// the web site.
    requester_feedback: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .override_rejection = "OverrideRejection",
        .requester_feedback = "RequesterFeedback",
    };
};

pub const ApproveAssignmentOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ApproveAssignmentInput, options: CallOptions) !ApproveAssignmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ApproveAssignmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.ApproveAssignment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ApproveAssignmentOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
