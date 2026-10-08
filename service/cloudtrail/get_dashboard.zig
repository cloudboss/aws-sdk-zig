const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RefreshSchedule = @import("refresh_schedule.zig").RefreshSchedule;
const DashboardStatus = @import("dashboard_status.zig").DashboardStatus;
const DashboardType = @import("dashboard_type.zig").DashboardType;
const Widget = @import("widget.zig").Widget;

pub const GetDashboardInput = struct {
    /// The name or ARN for the dashboard.
    dashboard_id: []const u8,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
    };
};

pub const GetDashboardOutput = struct {
    /// The timestamp that shows when the dashboard was created.
    created_timestamp: ?i64 = null,

    /// The ARN for the dashboard.
    dashboard_arn: ?[]const u8 = null,

    /// Provides information about failures for the last scheduled refresh.
    last_refresh_failure_reason: ?[]const u8 = null,

    /// The ID of the last dashboard refresh.
    last_refresh_id: ?[]const u8 = null,

    /// The refresh schedule for the dashboard, if configured.
    refresh_schedule: ?RefreshSchedule = null,

    /// The status of the dashboard.
    status: ?DashboardStatus = null,

    /// Indicates whether termination protection is enabled for the dashboard.
    termination_protection_enabled: ?bool = null,

    /// The type of dashboard.
    type: ?DashboardType = null,

    /// The timestamp that shows when the dashboard was last updated.
    updated_timestamp: ?i64 = null,

    /// An array of widgets for the dashboard.
    widgets: ?[]const Widget = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .dashboard_arn = "DashboardArn",
        .last_refresh_failure_reason = "LastRefreshFailureReason",
        .last_refresh_id = "LastRefreshId",
        .refresh_schedule = "RefreshSchedule",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .type = "Type",
        .updated_timestamp = "UpdatedTimestamp",
        .widgets = "Widgets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDashboardInput, options: CallOptions) !GetDashboardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GetDashboard");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDashboardOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDashboardOutput, body, allocator);
}
