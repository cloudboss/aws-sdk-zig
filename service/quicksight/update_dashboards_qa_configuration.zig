const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DashboardsQAStatus = @import("dashboards_qa_status.zig").DashboardsQAStatus;

pub const UpdateDashboardsQAConfigurationInput = struct {
    /// The ID of the Amazon Web Services account that contains the dashboard QA
    /// configuration that you want to update.
    aws_account_id: []const u8,

    /// The status of dashboards QA configuration that you want to update.
    dashboards_qa_status: DashboardsQAStatus,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboards_qa_status = "DashboardsQAStatus",
    };
};

pub const UpdateDashboardsQAConfigurationOutput = struct {
    /// A value that indicates whether the dashboard QA configuration is enabled or
    /// not.
    dashboards_qa_status: ?DashboardsQAStatus = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .dashboards_qa_status = "DashboardsQAStatus",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDashboardsQAConfigurationInput, options: CallOptions) !UpdateDashboardsQAConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDashboardsQAConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards-qa-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DashboardsQAStatus\":");
    try aws.json.writeValue(@TypeOf(input.dashboards_qa_status), input.dashboards_qa_status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDashboardsQAConfigurationOutput {
    var result: UpdateDashboardsQAConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDashboardsQAConfigurationOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
