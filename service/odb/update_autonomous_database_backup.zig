const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateAutonomousDatabaseBackupInput = struct {
    /// The unique identifier of the Autonomous Database backup to update.
    autonomous_database_backup_id: []const u8,

    /// The retention period, in days, for the Autonomous Database backup.
    retention_period_in_days: ?i32 = null,

    pub const json_field_names = .{
        .autonomous_database_backup_id = "autonomousDatabaseBackupId",
        .retention_period_in_days = "retentionPeriodInDays",
    };
};

pub const UpdateAutonomousDatabaseBackupOutput = struct {
    /// The unique identifier of the Autonomous Database backup that was updated.
    autonomous_database_backup_id: []const u8,

    /// The user-friendly name of the Autonomous Database backup.
    display_name: ?[]const u8 = null,

    /// The current status of the Autonomous Database backup.
    status: ?ResourceStatus = null,

    /// Additional information about the current status of the Autonomous Database
    /// backup, if applicable.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .autonomous_database_backup_id = "autonomousDatabaseBackupId",
        .display_name = "displayName",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutonomousDatabaseBackupInput, options: CallOptions) !UpdateAutonomousDatabaseBackupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutonomousDatabaseBackupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateAutonomousDatabaseBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutonomousDatabaseBackupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateAutonomousDatabaseBackupOutput, body, allocator);
}
