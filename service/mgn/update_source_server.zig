const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceServerConnectorAction = @import("source_server_connector_action.zig").SourceServerConnectorAction;
const DataReplicationInfo = @import("data_replication_info.zig").DataReplicationInfo;
const LaunchedInstance = @import("launched_instance.zig").LaunchedInstance;
const LifeCycle = @import("life_cycle.zig").LifeCycle;
const ReplicationType = @import("replication_type.zig").ReplicationType;
const SourceProperties = @import("source_properties.zig").SourceProperties;

pub const UpdateSourceServerInput = struct {
    /// Update Source Server request account ID.
    account_id: ?[]const u8 = null,

    /// Update Source Server request connector action.
    connector_action: ?SourceServerConnectorAction = null,

    /// Update Source Server request FQDN for action framework.
    fqdn_for_action_framework: ?[]const u8 = null,

    /// Update Source Server request platform operating system.
    platform: ?[]const u8 = null,

    /// Update Source Server request source server ID.
    source_server_id: []const u8,

    /// Update Source Server request user provided ID.
    user_provided_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountID",
        .connector_action = "connectorAction",
        .fqdn_for_action_framework = "fqdnForActionFramework",
        .platform = "platform",
        .source_server_id = "sourceServerID",
        .user_provided_id = "userProvidedID",
    };
};

pub const UpdateSourceServerOutput = @import("source_server.zig").SourceServer;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSourceServerInput, options: CallOptions) !UpdateSourceServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSourceServerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateSourceServer";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorAction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fqdn_for_action_framework) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fqdnForActionFramework\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.platform) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"platform\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;
    if (input.user_provided_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userProvidedID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSourceServerOutput {
    const result: UpdateSourceServerOutput = try aws.json.parseJsonObject(
        UpdateSourceServerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
