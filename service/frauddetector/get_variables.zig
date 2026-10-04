const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Variable = @import("variable.zig").Variable;

pub const GetVariablesInput = struct {
    /// The max size per page determined for the get variable request.
    max_results: ?i32 = null,

    /// The name of the variable.
    name: ?[]const u8 = null,

    /// The next page token of the get variable request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
    };
};

pub const GetVariablesOutput = struct {
    /// The next page token to be used in subsequent requests.
    next_token: ?[]const u8 = null,

    /// The names of the variables returned.
    variables: ?[]const Variable = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .variables = "variables",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVariablesInput, options: CallOptions) !GetVariablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVariablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.GetVariables");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVariablesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetVariablesOutput, body, allocator);
}
