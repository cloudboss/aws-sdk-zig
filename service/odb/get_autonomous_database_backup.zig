const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutonomousDatabaseBackup = @import("autonomous_database_backup.zig").AutonomousDatabaseBackup;

pub const GetAutonomousDatabaseBackupInput = struct {
    /// The unique identifier of the Autonomous Database backup to retrieve
    /// information about.
    autonomous_database_backup_id: []const u8,

    pub const json_field_names = .{
        .autonomous_database_backup_id = "autonomousDatabaseBackupId",
    };
};

pub const GetAutonomousDatabaseBackupOutput = struct {
    /// The details of the requested Autonomous Database backup.
    autonomous_database_backup: ?AutonomousDatabaseBackup = null,

    pub const json_field_names = .{
        .autonomous_database_backup = "autonomousDatabaseBackup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutonomousDatabaseBackupInput, options: CallOptions) !GetAutonomousDatabaseBackupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutonomousDatabaseBackupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.GetAutonomousDatabaseBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutonomousDatabaseBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAutonomousDatabaseBackupOutput, body, allocator);
}
