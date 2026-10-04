const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateRoutingControlStateEntry = @import("update_routing_control_state_entry.zig").UpdateRoutingControlStateEntry;

pub const UpdateRoutingControlStatesInput = struct {
    /// The Amazon Resource Names (ARNs) for the safety rules that you want to
    /// override when you're updating routing
    /// control states. You can override one safety rule or multiple safety rules by
    /// including one or more ARNs, separated
    /// by commas.
    ///
    /// For more information, see [
    /// Override safety rules to reroute
    /// traffic](https://docs.aws.amazon.com/r53recovery/latest/dg/routing-control.override-safety-rule.html) in the Amazon Route 53 Application Recovery Controller Developer Guide.
    safety_rules_to_override: ?[]const []const u8 = null,

    /// A set of routing control entries that you want to update.
    update_routing_control_state_entries: []const UpdateRoutingControlStateEntry,

    pub const json_field_names = .{
        .safety_rules_to_override = "SafetyRulesToOverride",
        .update_routing_control_state_entries = "UpdateRoutingControlStateEntries",
    };
};

pub const UpdateRoutingControlStatesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRoutingControlStatesInput, options: CallOptions) !UpdateRoutingControlStatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-cluster", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRoutingControlStatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-cluster", "Route53 Recovery Cluster", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ToggleCustomerAPI.UpdateRoutingControlStates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRoutingControlStatesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
