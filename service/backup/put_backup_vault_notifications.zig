const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupVaultEvent = @import("backup_vault_event.zig").BackupVaultEvent;

pub const PutBackupVaultNotificationsInput = struct {
    /// An array of events that indicate the status of jobs to back up resources to
    /// the backup
    /// vault. For the list of supported events, common use cases, and code samples,
    /// see [Notification options
    /// with
    /// Backup](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-notifications.html).
    backup_vault_events: []const BackupVaultEvent,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: []const u8,

    /// The Amazon Resource Name (ARN) that specifies the topic for a backup vault’s
    /// events; for
    /// example, `arn:aws:sns:us-west-2:111122223333:MyVaultTopic`.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_events = "BackupVaultEvents",
        .backup_vault_name = "BackupVaultName",
        .sns_topic_arn = "SNSTopicArn",
    };
};

pub const PutBackupVaultNotificationsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBackupVaultNotificationsInput, options: CallOptions) !PutBackupVaultNotificationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBackupVaultNotificationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/notification-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupVaultEvents\":");
    try aws.json.writeValue(@TypeOf(input.backup_vault_events), input.backup_vault_events, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SNSTopicArn\":");
    try aws.json.writeValue(@TypeOf(input.sns_topic_arn), input.sns_topic_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBackupVaultNotificationsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBackupVaultNotificationsOutput = .{};

    return result;
}
