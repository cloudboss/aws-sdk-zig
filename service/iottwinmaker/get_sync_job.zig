const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncJobStatus = @import("sync_job_status.zig").SyncJobStatus;

pub const GetSyncJobInput = struct {
    /// The sync source.
    ///
    /// Currently the only supported syncSource is `SITEWISE `.
    sync_source: []const u8,

    /// The workspace ID.
    workspace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .sync_source = "syncSource",
        .workspace_id = "workspaceId",
    };
};

pub const GetSyncJobOutput = struct {
    /// The sync job ARN.
    arn: []const u8,

    /// The creation date and time.
    creation_date_time: i64,

    /// The SyncJob response status.
    status: ?SyncJobStatus = null,

    /// The sync IAM role.
    sync_role: []const u8,

    /// The sync soucre.
    ///
    /// Currently the only supported syncSource is `SITEWISE `.
    sync_source: []const u8,

    /// The update date and time.
    update_date_time: i64,

    /// The ID of the workspace that contains the sync job.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .status = "status",
        .sync_role = "syncRole",
        .sync_source = "syncSource",
        .update_date_time = "updateDateTime",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSyncJobInput, options: CallOptions) !GetSyncJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSyncJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sync-jobs/");
    try path_buf.appendSlice(allocator, input.sync_source);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.workspace_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "workspace=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSyncJobOutput {
    var result: GetSyncJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSyncJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
