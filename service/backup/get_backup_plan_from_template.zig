const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupPlan = @import("backup_plan.zig").BackupPlan;

pub const GetBackupPlanFromTemplateInput = struct {
    /// Uniquely identifies a stored backup plan template.
    backup_plan_template_id: []const u8,

    pub const json_field_names = .{
        .backup_plan_template_id = "BackupPlanTemplateId",
    };
};

pub const GetBackupPlanFromTemplateOutput = struct {
    /// Returns the body of a backup plan based on the target template, including
    /// the name,
    /// rules, and backup vault of the plan.
    backup_plan_document: ?BackupPlan = null,

    pub const json_field_names = .{
        .backup_plan_document = "BackupPlanDocument",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBackupPlanFromTemplateInput, options: CallOptions) !GetBackupPlanFromTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBackupPlanFromTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup/template/plans/");
    try path_buf.appendSlice(allocator, input.backup_plan_template_id);
    try path_buf.appendSlice(allocator, "/toPlan");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBackupPlanFromTemplateOutput {
    const result: GetBackupPlanFromTemplateOutput = try aws.json.parseJsonObject(
        GetBackupPlanFromTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
