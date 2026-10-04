const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceKey = @import("resource_key.zig").ResourceKey;

pub const StartRemediationExecutionInput = struct {
    /// The list of names of Config rules that you want to run remediation execution
    /// for.
    config_rule_name: []const u8,

    /// A list of resource keys to be processed with the current request. Each
    /// element in the list consists of the resource type and resource ID.
    resource_keys: []const ResourceKey,

    pub const json_field_names = .{
        .config_rule_name = "ConfigRuleName",
        .resource_keys = "ResourceKeys",
    };
};

pub const StartRemediationExecutionOutput = struct {
    /// For resources that have failed to start execution, the API returns a
    /// resource key object.
    failed_items: ?[]const ResourceKey = null,

    /// Returns a failure message. For example, the resource is already compliant.
    failure_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .failed_items = "FailedItems",
        .failure_message = "FailureMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRemediationExecutionInput, options: CallOptions) !StartRemediationExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRemediationExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.StartRemediationExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRemediationExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartRemediationExecutionOutput, body, allocator);
}
