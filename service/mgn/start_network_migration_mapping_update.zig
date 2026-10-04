const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartNetworkMigrationMappingUpdateConstruct = @import("start_network_migration_mapping_update_construct.zig").StartNetworkMigrationMappingUpdateConstruct;
const StartNetworkMigrationMappingUpdateSegment = @import("start_network_migration_mapping_update_segment.zig").StartNetworkMigrationMappingUpdateSegment;

pub const StartNetworkMigrationMappingUpdateInput = struct {
    /// A list of construct updates to apply.
    constructs: ?[]const StartNetworkMigrationMappingUpdateConstruct = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: []const u8,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: []const u8,

    /// A list of segment updates to apply.
    segments: ?[]const StartNetworkMigrationMappingUpdateSegment = null,

    pub const json_field_names = .{
        .constructs = "constructs",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .segments = "segments",
    };
};

pub const StartNetworkMigrationMappingUpdateOutput = struct {
    /// The unique identifier of the mapping update job that was started.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "jobID",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartNetworkMigrationMappingUpdateInput, options: CallOptions) !StartNetworkMigrationMappingUpdateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartNetworkMigrationMappingUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/network-migration/StartNetworkMigrationMappingUpdate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.constructs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"constructs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkMigrationDefinitionID\":");
    try aws.json.writeValue(@TypeOf(input.network_migration_definition_id), input.network_migration_definition_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkMigrationExecutionID\":");
    try aws.json.writeValue(@TypeOf(input.network_migration_execution_id), input.network_migration_execution_id, allocator, &body_buf);
    has_prev = true;
    if (input.segments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"segments\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartNetworkMigrationMappingUpdateOutput {
    var result: StartNetworkMigrationMappingUpdateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartNetworkMigrationMappingUpdateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
