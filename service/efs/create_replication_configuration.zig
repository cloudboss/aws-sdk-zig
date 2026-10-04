const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationToCreate = @import("destination_to_create.zig").DestinationToCreate;
const Destination = @import("destination.zig").Destination;

pub const CreateReplicationConfigurationInput = struct {
    /// An array of destination configuration objects. Only one destination
    /// configuration object is supported.
    destinations: []const DestinationToCreate,

    /// Specifies the Amazon EFS file system that you want to replicate. This file
    /// system cannot already be
    /// a source or destination file system in another replication configuration.
    source_file_system_id: []const u8,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .source_file_system_id = "SourceFileSystemId",
    };
};

pub const CreateReplicationConfigurationOutput = @import("replication_configuration_description.zig").ReplicationConfigurationDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationConfigurationInput, options: CallOptions) !CreateReplicationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.source_file_system_id);
    try path_buf.appendSlice(allocator, "/replication-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destinations\":");
    try aws.json.writeValue(@TypeOf(input.destinations), input.destinations, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationConfigurationOutput {
    const result: CreateReplicationConfigurationOutput = try aws.json.parseJsonObject(
        CreateReplicationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
