const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkMigrationMapperSegmentConstruct = @import("network_migration_mapper_segment_construct.zig").NetworkMigrationMapperSegmentConstruct;

pub const GetNetworkMigrationMapperSegmentConstructInput = struct {
    /// The unique identifier of the construct within the segment.
    construct_id: []const u8,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: []const u8,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: []const u8,

    /// The unique identifier of the mapper segment.
    segment_id: []const u8,

    pub const json_field_names = .{
        .construct_id = "constructID",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .segment_id = "segmentID",
    };
};

pub const GetNetworkMigrationMapperSegmentConstructOutput = struct {
    /// The construct metadata including type, name, and configuration.
    construct: ?NetworkMigrationMapperSegmentConstruct = null,

    pub const json_field_names = .{
        .construct = "construct",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNetworkMigrationMapperSegmentConstructInput, options: CallOptions) !GetNetworkMigrationMapperSegmentConstructOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNetworkMigrationMapperSegmentConstructInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/network-migration/GetNetworkMigrationMapperSegmentConstruct";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"constructID\":");
    try aws.json.writeValue(@TypeOf(input.construct_id), input.construct_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkMigrationDefinitionID\":");
    try aws.json.writeValue(@TypeOf(input.network_migration_definition_id), input.network_migration_definition_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkMigrationExecutionID\":");
    try aws.json.writeValue(@TypeOf(input.network_migration_execution_id), input.network_migration_execution_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"segmentID\":");
    try aws.json.writeValue(@TypeOf(input.segment_id), input.segment_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNetworkMigrationMapperSegmentConstructOutput {
    var result: GetNetworkMigrationMapperSegmentConstructOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetNetworkMigrationMapperSegmentConstructOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
