const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartReplicationMigrationTypeValue = @import("start_replication_migration_type_value.zig").StartReplicationMigrationTypeValue;
const DataMigration = @import("data_migration.zig").DataMigration;

pub const StartDataMigrationInput = struct {
    /// The identifier (name or ARN) of the data migration to start.
    data_migration_identifier: []const u8,

    /// Specifies the start type for the data migration. Valid values include
    /// `start-replication`, `reload-target`, and
    /// `resume-processing`.
    start_type: StartReplicationMigrationTypeValue,

    pub const json_field_names = .{
        .data_migration_identifier = "DataMigrationIdentifier",
        .start_type = "StartType",
    };
};

pub const StartDataMigrationOutput = struct {
    /// The data migration that DMS started.
    data_migration: ?DataMigration = null,

    pub const json_field_names = .{
        .data_migration = "DataMigration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataMigrationInput, options: CallOptions) !StartDataMigrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataMigrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.StartDataMigration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataMigrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDataMigrationOutput, body, allocator);
}
