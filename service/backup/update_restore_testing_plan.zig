const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestoreTestingPlanForUpdate = @import("restore_testing_plan_for_update.zig").RestoreTestingPlanForUpdate;

pub const UpdateRestoreTestingPlanInput = struct {
    /// Specifies the body of a restore testing plan.
    restore_testing_plan: RestoreTestingPlanForUpdate,

    /// The name of the restore testing plan name.
    restore_testing_plan_name: []const u8,

    pub const json_field_names = .{
        .restore_testing_plan = "RestoreTestingPlan",
        .restore_testing_plan_name = "RestoreTestingPlanName",
    };
};

pub const UpdateRestoreTestingPlanOutput = struct {
    /// The time the resource testing plan was
    /// created.
    creation_time: i64,

    /// Unique ARN (Amazon Resource Name) of the restore testing plan.
    restore_testing_plan_arn: []const u8,

    /// The name cannot be changed after creation. The name consists of
    /// only alphanumeric characters and underscores. Maximum length is 50.
    restore_testing_plan_name: []const u8,

    /// The time the update completed for the restore
    /// testing plan.
    update_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .restore_testing_plan_arn = "RestoreTestingPlanArn",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRestoreTestingPlanInput, options: CallOptions) !UpdateRestoreTestingPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRestoreTestingPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restore-testing/plans/");
    try path_buf.appendSlice(allocator, input.restore_testing_plan_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RestoreTestingPlan\":");
    try aws.json.writeValue(@TypeOf(input.restore_testing_plan), input.restore_testing_plan, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRestoreTestingPlanOutput {
    const result: UpdateRestoreTestingPlanOutput = try aws.json.parseJsonObject(
        UpdateRestoreTestingPlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
