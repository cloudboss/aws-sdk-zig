const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestoreTestingPlanForCreate = @import("restore_testing_plan_for_create.zig").RestoreTestingPlanForCreate;

pub const CreateRestoreTestingPlanInput = struct {
    /// This is a unique string that identifies the request and
    /// allows failed requests to be retriedwithout the risk of running
    /// the operation twice. This parameter is optional. If used, this
    /// parameter must contain 1 to 50 alphanumeric or '-_.' characters.
    creator_request_id: ?[]const u8 = null,

    /// A restore testing plan must contain a unique `RestoreTestingPlanName` string
    /// you create and must contain a `ScheduleExpression` cron. You may optionally
    /// include a `StartWindowHours` integer and a `CreatorRequestId`
    /// string.
    ///
    /// The `RestoreTestingPlanName` is a unique string that is the name of the
    /// restore testing plan. This cannot be changed after creation, and it must
    /// consist of only
    /// alphanumeric characters and underscores.
    restore_testing_plan: RestoreTestingPlanForCreate,

    /// The tags to assign to the restore testing plan.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .restore_testing_plan = "RestoreTestingPlan",
        .tags = "Tags",
    };
};

pub const CreateRestoreTestingPlanOutput = struct {
    /// The date and time a restore testing plan was created, in Unix format
    /// and Coordinated Universal Time (UTC). The value of `CreationTime`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents
    /// Friday, January 26, 2018 12:11:30.087AM.
    creation_time: i64,

    /// An Amazon Resource Name (ARN) that uniquely identifies the created
    /// restore testing plan.
    restore_testing_plan_arn: []const u8,

    /// This unique string is the name of the restore testing plan.
    ///
    /// The name cannot be changed after creation. The name consists of only
    /// alphanumeric characters and underscores. Maximum length is 50.
    restore_testing_plan_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .restore_testing_plan_arn = "RestoreTestingPlanArn",
        .restore_testing_plan_name = "RestoreTestingPlanName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRestoreTestingPlanInput, options: CallOptions) !CreateRestoreTestingPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRestoreTestingPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/restore-testing/plans";

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
    try body_buf.appendSlice(allocator, "\"RestoreTestingPlan\":");
    try aws.json.writeValue(@TypeOf(input.restore_testing_plan), input.restore_testing_plan, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRestoreTestingPlanOutput {
    var result: CreateRestoreTestingPlanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRestoreTestingPlanOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
