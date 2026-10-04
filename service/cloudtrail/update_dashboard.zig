const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RefreshSchedule = @import("refresh_schedule.zig").RefreshSchedule;
const RequestWidget = @import("request_widget.zig").RequestWidget;
const DashboardType = @import("dashboard_type.zig").DashboardType;
const Widget = @import("widget.zig").Widget;

pub const UpdateDashboardInput = struct {
    /// The name or ARN of the dashboard.
    dashboard_id: []const u8,

    /// The refresh schedule configuration for the dashboard.
    refresh_schedule: ?RefreshSchedule = null,

    /// Specifies whether termination protection is enabled for the dashboard. If
    /// termination protection is enabled, you cannot delete the dashboard until
    /// termination protection is disabled.
    termination_protection_enabled: ?bool = null,

    /// An array of widgets for the dashboard. A custom dashboard can have a maximum
    /// of 10 widgets.
    ///
    /// To add new widgets, pass in an array that includes the existing widgets
    /// along with any new widgets. Run the `GetDashboard` operation to get the list
    /// of widgets for the dashboard.
    ///
    /// To remove widgets, pass in an array that includes the existing widgets minus
    /// the widgets you want removed.
    widgets: ?[]const RequestWidget = null,

    pub const json_field_names = .{
        .dashboard_id = "DashboardId",
        .refresh_schedule = "RefreshSchedule",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .widgets = "Widgets",
    };
};

pub const UpdateDashboardOutput = struct {
    /// The timestamp that shows when the dashboard was created.
    created_timestamp: ?i64 = null,

    /// The ARN for the dashboard.
    dashboard_arn: ?[]const u8 = null,

    /// The name for the dashboard.
    name: ?[]const u8 = null,

    /// The refresh schedule for the dashboard, if configured.
    refresh_schedule: ?RefreshSchedule = null,

    /// Indicates whether termination protection is enabled for the dashboard.
    termination_protection_enabled: ?bool = null,

    /// The type of dashboard.
    @"type": ?DashboardType = null,

    /// The timestamp that shows when the dashboard was updated.
    updated_timestamp: ?i64 = null,

    /// An array of widgets for the dashboard.
    widgets: ?[]const Widget = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .dashboard_arn = "DashboardArn",
        .name = "Name",
        .refresh_schedule = "RefreshSchedule",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .@"type" = "Type",
        .updated_timestamp = "UpdatedTimestamp",
        .widgets = "Widgets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDashboardInput, options: CallOptions) !UpdateDashboardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDashboardInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.UpdateDashboard");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDashboardOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDashboardOutput, body, allocator);
}
