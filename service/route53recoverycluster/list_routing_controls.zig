const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingControl = @import("routing_control.zig").RoutingControl;

pub const ListRoutingControlsInput = struct {
    /// The Amazon Resource Name (ARN) of the control panel of the routing controls
    /// to list.
    control_panel_arn: ?[]const u8 = null,

    /// The number of routing controls objects that you want to return with this
    /// call. The default value is 500.
    max_results: ?i32 = null,

    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .control_panel_arn = "ControlPanelArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListRoutingControlsOutput = struct {
    /// The token for the next set of results. You receive this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    /// The list of routing controls.
    routing_controls: ?[]const RoutingControl = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .routing_controls = "RoutingControls",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRoutingControlsInput, options: CallOptions) !ListRoutingControlsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRoutingControlsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ToggleCustomerAPI.ListRoutingControls");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRoutingControlsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListRoutingControlsOutput, body, allocator);
}
