const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ResolveCaseInput = struct {
    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string formatted as shown in this example:
    /// case-*12345678910-2013-c4c1d2bf33c5cf47*
    case_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub const ResolveCaseOutput = struct {
    /// The status of the case after the ResolveCase request was
    /// processed.
    final_case_status: ?[]const u8 = null,

    /// The status of the case when the ResolveCase request was sent.
    initial_case_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .final_case_status = "finalCaseStatus",
        .initial_case_status = "initialCaseStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResolveCaseInput, options: CallOptions) !ResolveCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResolveCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.ResolveCase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResolveCaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ResolveCaseOutput, body, allocator);
}
