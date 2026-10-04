const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetPolicyInputItem = @import("batch_get_policy_input_item.zig").BatchGetPolicyInputItem;
const BatchGetPolicyErrorItem = @import("batch_get_policy_error_item.zig").BatchGetPolicyErrorItem;
const BatchGetPolicyOutputItem = @import("batch_get_policy_output_item.zig").BatchGetPolicyOutputItem;

pub const BatchGetPolicyInput = struct {
    /// An array of up to 100 policies you want information about.
    requests: []const BatchGetPolicyInputItem,

    pub const json_field_names = .{
        .requests = "requests",
    };
};

pub const BatchGetPolicyOutput = struct {
    /// Information about the policies from the request that resulted in an error.
    /// These results are returned in the order they were requested.
    errors: ?[]const BatchGetPolicyErrorItem = null,

    /// Information about the policies listed in the request that were successfully
    /// returned. These results are returned in the order they were requested.
    results: ?[]const BatchGetPolicyOutputItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetPolicyInput, options: CallOptions) !BatchGetPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "verifiedpermissions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.BatchGetPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchGetPolicyOutput, body, allocator);
}
