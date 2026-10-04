const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationError = @import("migration_error.zig").MigrationError;
const MigrationSource = @import("migration_source.zig").MigrationSource;

pub const GetMigrationInput = struct {
    /// The unique identifier of the migration job to retrieve.
    migration_id: []const u8,

    pub const json_field_names = .{
        .migration_id = "migrationId",
    };
};

pub const GetMigrationOutput = struct {
    /// The unique identifier of the OpenSearch application associated with the
    /// migration.
    application_id: ?[]const u8 = null,

    /// The date and time when the migration job was created.
    created_at: ?i64 = null,

    /// Error details if the migration failed or completed with errors.
    @"error": ?MigrationError = null,

    /// The number of saved objects exported from the source data source.
    exported_count: ?i32 = null,

    /// The number of saved objects successfully imported into the target workspace.
    imported_count: ?i32 = null,

    /// The unique identifier of the migration job.
    migration_id: ?[]const u8 = null,

    /// The source configuration for the migration, including the data source ARN.
    source: ?MigrationSource = null,

    /// The current status of the migration job. Valid values are `PENDING`,
    /// `IN_PROGRESS`, `SUCCEEDED`, and `FAILED`.
    status: ?[]const u8 = null,

    /// The date and time when the migration job was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .created_at = "createdAt",
        .@"error" = "error",
        .exported_count = "exportedCount",
        .imported_count = "importedCount",
        .migration_id = "migrationId",
        .source = "source",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMigrationInput, options: CallOptions) !GetMigrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMigrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/app-migrations/");
    try path_buf.appendSlice(allocator, input.migration_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMigrationOutput {
    const result: GetMigrationOutput = try aws.json.parseJsonObject(
        GetMigrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
