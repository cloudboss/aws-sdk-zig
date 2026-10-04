const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomaticTapeCreationRule = @import("automatic_tape_creation_rule.zig").AutomaticTapeCreationRule;

pub const UpdateAutomaticTapeCreationPolicyInput = struct {
    /// An automatic tape creation policy consists of a list of automatic tape
    /// creation rules.
    /// The rules determine when and how to automatically create new tapes.
    automatic_tape_creation_rules: []const AutomaticTapeCreationRule,

    gateway_arn: []const u8,

    pub const json_field_names = .{
        .automatic_tape_creation_rules = "AutomaticTapeCreationRules",
        .gateway_arn = "GatewayARN",
    };
};

pub const UpdateAutomaticTapeCreationPolicyOutput = struct {
    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutomaticTapeCreationPolicyInput, options: CallOptions) !UpdateAutomaticTapeCreationPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutomaticTapeCreationPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.UpdateAutomaticTapeCreationPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutomaticTapeCreationPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAutomaticTapeCreationPolicyOutput, body, allocator);
}
