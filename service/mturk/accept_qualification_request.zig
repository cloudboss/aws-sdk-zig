const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AcceptQualificationRequestInput = struct {
    /// The value of the Qualification. You can omit this value if you are using the
    /// presence or absence of the Qualification as the basis for a HIT requirement.
    integer_value: ?i32 = null,

    /// The ID of the Qualification request, as returned by the
    /// `GetQualificationRequests` operation.
    qualification_request_id: []const u8,

    pub const json_field_names = .{
        .integer_value = "IntegerValue",
        .qualification_request_id = "QualificationRequestId",
    };
};

pub const AcceptQualificationRequestOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptQualificationRequestInput, options: CallOptions) !AcceptQualificationRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptQualificationRequestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MTurkRequesterServiceV20170117.AcceptQualificationRequest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptQualificationRequestOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
