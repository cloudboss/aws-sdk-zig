const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionMode = @import("deletion_mode.zig").DeletionMode;

pub const DeleteReplicationConfigurationInput = struct {
    /// When replicating across Amazon Web Services accounts or across Amazon Web
    /// Services Regions,
    /// Amazon EFS deletes the replication configuration from both the source
    /// and destination account or Region (`ALL_CONFIGURATIONS`) by default.
    /// If there's a configuration or permissions issue that prevents Amazon EFS
    /// from deleting the
    /// replication configuration from both sides, you can use the
    /// `LOCAL_CONFIGURATION_ONLY` mode
    /// to delete the replication configuration from only the local side (the
    /// account
    /// or Region from which the delete is performed).
    ///
    /// Only use the `LOCAL_CONFIGURATION_ONLY` mode in the case that Amazon EFS is
    /// unable
    /// to delete the replication configuration in both the source and destination
    /// account or Region.
    /// Deleting the local configuration
    /// leaves the configuration in the other account or Region unrecoverable.
    ///
    /// Additionally, do not use this mode for same-account, same-region replication
    /// as doing so results in a
    /// BadRequest exception error.
    deletion_mode: ?DeletionMode = null,

    /// The ID of the source file system in the replication configuration.
    source_file_system_id: []const u8,

    pub const json_field_names = .{
        .deletion_mode = "DeletionMode",
        .source_file_system_id = "SourceFileSystemId",
    };
};

pub const DeleteReplicationConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteReplicationConfigurationInput, options: CallOptions) !DeleteReplicationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteReplicationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.source_file_system_id);
    try path_buf.appendSlice(allocator, "/replication-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.deletion_mode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deletionMode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteReplicationConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteReplicationConfigurationOutput = .{};

    return result;
}
