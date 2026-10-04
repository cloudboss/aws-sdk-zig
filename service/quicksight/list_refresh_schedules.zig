const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RefreshSchedule = @import("refresh_schedule.zig").RefreshSchedule;

pub const ListRefreshSchedulesInput = struct {
    /// The Amazon Web Services account ID.
    aws_account_id: []const u8,

    /// The ID of the dataset.
    data_set_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .data_set_id = "DataSetId",
    };
};

pub const ListRefreshSchedulesOutput = struct {
    /// The list of refresh schedules for the dataset.
    refresh_schedules: ?[]const RefreshSchedule = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .refresh_schedules = "RefreshSchedules",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRefreshSchedulesInput, options: CallOptions) !ListRefreshSchedulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRefreshSchedulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/data-sets/");
    try path_buf.appendSlice(allocator, input.data_set_id);
    try path_buf.appendSlice(allocator, "/refresh-schedules");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRefreshSchedulesOutput {
    var result: ListRefreshSchedulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRefreshSchedulesOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
