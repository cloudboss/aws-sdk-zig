const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouterOutputRoutedState = @import("router_output_routed_state.zig").RouterOutputRoutedState;

pub const TakeRouterInputInput = struct {
    /// The Amazon Resource Name (ARN) of the router input that you want to
    /// associate with a router output.
    router_input_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the router output that you want to
    /// associate with a router input.
    router_output_arn: []const u8,

    pub const json_field_names = .{
        .router_input_arn = "RouterInputArn",
        .router_output_arn = "RouterOutputArn",
    };
};

pub const TakeRouterInputOutput = struct {
    /// The state of the association between the router input and output.
    routed_state: RouterOutputRoutedState,

    /// The ARN of the associated router input.
    router_input_arn: ?[]const u8 = null,

    /// The name of the associated router input.
    router_input_name: ?[]const u8 = null,

    /// The ARN of the associated router output.
    router_output_arn: []const u8,

    /// The name of the associated router output.
    router_output_name: []const u8,

    pub const json_field_names = .{
        .routed_state = "RoutedState",
        .router_input_arn = "RouterInputArn",
        .router_input_name = "RouterInputName",
        .router_output_arn = "RouterOutputArn",
        .router_output_name = "RouterOutputName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TakeRouterInputInput, options: CallOptions) !TakeRouterInputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TakeRouterInputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/routerOutput/takeRouterInput/");
    try path_buf.appendSlice(allocator, input.router_output_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.router_input_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouterInputArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TakeRouterInputOutput {
    const result: TakeRouterInputOutput = try aws.json.parseJsonObject(
        TakeRouterInputOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
