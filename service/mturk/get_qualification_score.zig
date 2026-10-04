const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Qualification = @import("qualification.zig").Qualification;

pub const GetQualificationScoreInput = struct {
    /// The ID of the QualificationType.
    qualification_type_id: []const u8,

    /// The ID of the Worker whose Qualification is being updated.
    worker_id: []const u8,

    pub const json_field_names = .{
        .qualification_type_id = "QualificationTypeId",
        .worker_id = "WorkerId",
    };
};

pub const GetQualificationScoreOutput = struct {
    /// The Qualification data structure of the Qualification
    /// assigned to a user, including the Qualification type and the value
    /// (score).
    qualification: ?Qualification = null,

    pub const json_field_names = .{
        .qualification = "Qualification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQualificationScoreInput, options: CallOptions) !GetQualificationScoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQualificationScoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.GetQualificationScore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQualificationScoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQualificationScoreOutput, body, allocator);
}
