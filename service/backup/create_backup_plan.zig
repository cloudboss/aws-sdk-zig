const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupPlanInput = @import("backup_plan_input.zig").BackupPlanInput;
const AdvancedBackupSetting = @import("advanced_backup_setting.zig").AdvancedBackupSetting;

pub const CreateBackupPlanInput = struct {
    /// The body of a backup plan. Includes a `BackupPlanName` and one or
    /// more sets of `Rules`.
    backup_plan: BackupPlanInput,

    /// The tags to assign to the backup plan.
    backup_plan_tags: ?[]const aws.map.StringMapEntry = null,

    /// Identifies the request and allows failed requests to be retried without the
    /// risk of
    /// running the operation twice. If the request includes a `CreatorRequestId`
    /// that
    /// matches an existing backup plan, that plan is returned. This parameter is
    /// optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    creator_request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan = "BackupPlan",
        .backup_plan_tags = "BackupPlanTags",
        .creator_request_id = "CreatorRequestId",
    };
};

pub const CreateBackupPlanOutput = struct {
    /// The settings for a resource type. This option is only
    /// available for Windows Volume Shadow Copy Service (VSS) backup jobs.
    advanced_backup_settings: ?[]const AdvancedBackupSetting = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50`.
    backup_plan_arn: ?[]const u8 = null,

    /// The ID of the backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// The date and time that a backup plan is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
    /// 1,024 bytes
    /// long. They cannot be edited.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .advanced_backup_settings = "AdvancedBackupSettings",
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .creation_date = "CreationDate",
        .version_id = "VersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBackupPlanInput, options: CallOptions) !CreateBackupPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBackupPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/backup/plans";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupPlan\":");
    try aws.json.writeValue(@TypeOf(input.backup_plan), input.backup_plan, allocator, &body_buf);
    has_prev = true;
    if (input.backup_plan_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BackupPlanTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.creator_request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CreatorRequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBackupPlanOutput {
    const result: CreateBackupPlanOutput = try aws.json.parseJsonObject(
        CreateBackupPlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
