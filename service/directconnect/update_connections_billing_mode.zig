const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestBillingMode = @import("request_billing_mode.zig").RequestBillingMode;
const BillingMode = @import("billing_mode.zig").BillingMode;
const Connection = @import("connection.zig").Connection;

pub const UpdateConnectionsBillingModeInput = struct {
    /// The billing mode to apply to the specified connections. The valid values are
    /// `PayAsYouGo`, `FlatRateTier1`, `FlatRateTier2`,
    /// `FlatRateTier3`, `FlatRateTier4`, and
    /// `FlatRateTier5`.
    billing_mode: RequestBillingMode,

    /// The IDs of the connections to update. You can specify from 1 to 200
    /// connections.
    connection_ids: []const []const u8,

    pub const json_field_names = .{
        .billing_mode = "billingMode",
        .connection_ids = "connectionIds",
    };
};

pub const UpdateConnectionsBillingModeOutput = struct {
    /// The billing mode applied to the connections.
    billing_mode: ?BillingMode = null,

    /// The connections with the updated billing mode.
    connections: ?[]const Connection = null,

    pub const json_field_names = .{
        .billing_mode = "billingMode",
        .connections = "connections",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectionsBillingModeInput, options: CallOptions) !UpdateConnectionsBillingModeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectionsBillingModeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.UpdateConnectionsBillingMode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectionsBillingModeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateConnectionsBillingModeOutput, body, allocator);
}
