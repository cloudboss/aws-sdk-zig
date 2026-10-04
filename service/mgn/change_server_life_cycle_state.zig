const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeServerLifeCycleStateSourceServerLifecycle = @import("change_server_life_cycle_state_source_server_lifecycle.zig").ChangeServerLifeCycleStateSourceServerLifecycle;
const SourceServerConnectorAction = @import("source_server_connector_action.zig").SourceServerConnectorAction;
const DataReplicationInfo = @import("data_replication_info.zig").DataReplicationInfo;
const LaunchedInstance = @import("launched_instance.zig").LaunchedInstance;
const LifeCycle = @import("life_cycle.zig").LifeCycle;
const ReplicationType = @import("replication_type.zig").ReplicationType;
const SourceProperties = @import("source_properties.zig").SourceProperties;

pub const ChangeServerLifeCycleStateInput = struct {
    /// The request to change the source server migration account ID.
    account_id: ?[]const u8 = null,

    /// The request to change the source server migration lifecycle state.
    life_cycle: ChangeServerLifeCycleStateSourceServerLifecycle,

    /// The request to change the source server migration lifecycle state by source
    /// server ID.
    source_server_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountID",
        .life_cycle = "lifeCycle",
        .source_server_id = "sourceServerID",
    };
};

pub const ChangeServerLifeCycleStateOutput = @import("source_server.zig").SourceServer;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangeServerLifeCycleStateInput, options: CallOptions) !ChangeServerLifeCycleStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangeServerLifeCycleStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ChangeServerLifeCycleState";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lifeCycle\":");
    try aws.json.writeValue(@TypeOf(input.life_cycle), input.life_cycle, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangeServerLifeCycleStateOutput {
    const result: ChangeServerLifeCycleStateOutput = try aws.json.parseJsonObject(
        ChangeServerLifeCycleStateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
