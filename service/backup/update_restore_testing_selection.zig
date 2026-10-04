const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestoreTestingSelectionForUpdate = @import("restore_testing_selection_for_update.zig").RestoreTestingSelectionForUpdate;

pub const UpdateRestoreTestingSelectionInput = struct {
    /// The restore testing plan name is required to update the
    /// indicated testing plan.
    restore_testing_plan_name: []const u8,

    /// To update your restore testing selection, you can use either
    /// protected resource ARNs or conditions, but not both. That is, if your
    /// selection has `ProtectedResourceArns`, requesting an update
    /// with the parameter `ProtectedResourceConditions` will be
    /// unsuccessful.
    restore_testing_selection: RestoreTestingSelectionForUpdate,

    /// The required restore testing selection name of the restore
    /// testing selection you wish to update.
    restore_testing_selection_name: []const u8,

    pub const json_field_names = .{
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection = "RestoreTestingSelection",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
    };
};

pub const UpdateRestoreTestingSelectionOutput = struct {
    /// The time the resource testing selection was
    /// updated successfully.
    creation_time: i64,

    /// Unique string that is the name of the restore testing plan.
    restore_testing_plan_arn: []const u8,

    /// The restore testing plan with which the updated restore
    /// testing selection is associated.
    restore_testing_plan_name: []const u8,

    /// The returned restore testing selection name.
    restore_testing_selection_name: []const u8,

    /// The time the update completed for the restore
    /// testing selection.
    update_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .restore_testing_plan_arn = "RestoreTestingPlanArn",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRestoreTestingSelectionInput, options: CallOptions) !UpdateRestoreTestingSelectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRestoreTestingSelectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restore-testing/plans/");
    try path_buf.appendSlice(allocator, input.restore_testing_plan_name);
    try path_buf.appendSlice(allocator, "/selections/");
    try path_buf.appendSlice(allocator, input.restore_testing_selection_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RestoreTestingSelection\":");
    try aws.json.writeValue(@TypeOf(input.restore_testing_selection), input.restore_testing_selection, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRestoreTestingSelectionOutput {
    const result: UpdateRestoreTestingSelectionOutput = try aws.json.parseJsonObject(
        UpdateRestoreTestingSelectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
