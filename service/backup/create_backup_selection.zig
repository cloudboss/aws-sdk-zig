const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupSelection = @import("backup_selection.zig").BackupSelection;

pub const CreateBackupSelectionInput = struct {
    /// The ID of the backup plan.
    backup_plan_id: []const u8,

    /// The body of a request to assign a set of resources to a backup plan.
    backup_selection: BackupSelection,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice. This parameter is optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    creator_request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_id = "BackupPlanId",
        .backup_selection = "BackupSelection",
        .creator_request_id = "CreatorRequestId",
    };
};

pub const CreateBackupSelectionOutput = struct {
    /// The ID of the backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// The date and time a backup selection is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// Uniquely identifies the body of a request to assign a set of resources to a
    /// backup
    /// plan.
    selection_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_id = "BackupPlanId",
        .creation_date = "CreationDate",
        .selection_id = "SelectionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBackupSelectionInput, options: CallOptions) !CreateBackupSelectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBackupSelectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup/plans/");
    try path_buf.appendSlice(allocator, input.backup_plan_id);
    try path_buf.appendSlice(allocator, "/selections");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupSelection\":");
    try aws.json.writeValue(@TypeOf(input.backup_selection), input.backup_selection, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBackupSelectionOutput {
    var result: CreateBackupSelectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBackupSelectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
