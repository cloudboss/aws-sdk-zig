const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestoreTestingSelectionForCreate = @import("restore_testing_selection_for_create.zig").RestoreTestingSelectionForCreate;

pub const CreateRestoreTestingSelectionInput = struct {
    /// This is an optional unique string that identifies the request and allows
    /// failed requests to be retried without the risk of running the operation
    /// twice. If used, this parameter must contain
    /// 1 to 50 alphanumeric or '-_.' characters.
    creator_request_id: ?[]const u8 = null,

    /// Input the restore testing plan name that was returned from the
    /// related CreateRestoreTestingPlan request.
    restore_testing_plan_name: []const u8,

    /// This consists of `RestoreTestingSelectionName`,
    /// `ProtectedResourceType`, and one of the following:
    ///
    /// * `ProtectedResourceArns`
    ///
    /// * `ProtectedResourceConditions`
    ///
    /// Each protected resource type can have one single value.
    ///
    /// A restore testing selection can include a wildcard value ("*") for
    /// `ProtectedResourceArns` along with `ProtectedResourceConditions`.
    /// Alternatively, you can include up to 30 specific protected resource ARNs in
    /// `ProtectedResourceArns`.
    restore_testing_selection: RestoreTestingSelectionForCreate,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection = "RestoreTestingSelection",
    };
};

pub const CreateRestoreTestingSelectionOutput = struct {
    /// The time that the resource testing selection was created.
    creation_time: i64,

    /// The ARN of the restore testing plan with which the restore
    /// testing selection is associated.
    restore_testing_plan_arn: []const u8,

    /// The name of the restore testing plan.
    ///
    /// The name cannot be changed after creation. The name consists of only
    /// alphanumeric characters and underscores. Maximum length is 50.
    restore_testing_plan_name: []const u8,

    /// The name of the restore testing selection for the related restore testing
    /// plan.
    ///
    /// The name cannot be changed after creation. The name consists of only
    /// alphanumeric characters and underscores. Maximum length is 50.
    restore_testing_selection_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .restore_testing_plan_arn = "RestoreTestingPlanArn",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRestoreTestingSelectionInput, options: CallOptions) !CreateRestoreTestingSelectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRestoreTestingSelectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restore-testing/plans/");
    try path_buf.appendSlice(allocator, input.restore_testing_plan_name);
    try path_buf.appendSlice(allocator, "/selections");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.creator_request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CreatorRequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRestoreTestingSelectionOutput {
    var result: CreateRestoreTestingSelectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRestoreTestingSelectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
