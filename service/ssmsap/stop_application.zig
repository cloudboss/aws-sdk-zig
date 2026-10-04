const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectedEntityType = @import("connected_entity_type.zig").ConnectedEntityType;

pub const StopApplicationInput = struct {
    /// The ID of the application.
    application_id: []const u8,

    /// Boolean. If included and if set to `True`, the StopApplication operation
    /// will shut down the associated Amazon EC2 instance in addition to the
    /// application.
    include_ec_2_instance_shutdown: ?bool = null,

    /// Specify the `ConnectedEntityType`. Accepted type is `DBMS`.
    ///
    /// If this parameter is included, the connected DBMS (Database Management
    /// System) will be stopped.
    stop_connected_entity: ?ConnectedEntityType = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .include_ec_2_instance_shutdown = "IncludeEc2InstanceShutdown",
        .stop_connected_entity = "StopConnectedEntity",
    };
};

pub const StopApplicationOutput = struct {
    /// The ID of the operation.
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopApplicationInput, options: CallOptions) !StopApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-sap", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-sap", "Ssm Sap", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/stop-application";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicationId\":");
    try aws.json.writeValue(@TypeOf(input.application_id), input.application_id, allocator, &body_buf);
    has_prev = true;
    if (input.include_ec_2_instance_shutdown) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeEc2InstanceShutdown\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stop_connected_entity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StopConnectedEntity\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopApplicationOutput {
    var result: StopApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StopApplicationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
