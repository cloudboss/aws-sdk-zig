const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleConfig = @import("schedule_config.zig").ScheduleConfig;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;

pub const UpdateScheduledReportInput = struct {
    /// The ARN of the scheduled report to update.
    arn: []const u8,

    /// Set to true to clear existing widgetDateRangeOverride.
    clear_widget_date_range_override: ?bool = null,

    /// Set to true to clear existing widgetIds.
    clear_widget_ids: ?bool = null,

    /// The ARN of the dashboard to associate with the scheduled report.
    dashboard_arn: ?[]const u8 = null,

    /// The new description for the scheduled report.
    description: ?[]const u8 = null,

    /// The new name for the scheduled report.
    name: ?[]const u8 = null,

    /// The updated schedule configuration for the report.
    schedule_config: ?ScheduleConfig = null,

    /// The ARN of the IAM role that the scheduled report uses to execute. Amazon
    /// Web Services Billing and Cost Management Dashboards will assume this IAM
    /// role while executing the scheduled report.
    scheduled_report_execution_role_arn: ?[]const u8 = null,

    /// The date range override to apply to widgets in the scheduled report.
    widget_date_range_override: ?DateTimeRange = null,

    /// The list of widget identifiers to include in the scheduled report. If not
    /// specified, all widgets in the dashboard are included.
    widget_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .clear_widget_date_range_override = "clearWidgetDateRangeOverride",
        .clear_widget_ids = "clearWidgetIds",
        .dashboard_arn = "dashboardArn",
        .description = "description",
        .name = "name",
        .schedule_config = "scheduleConfig",
        .scheduled_report_execution_role_arn = "scheduledReportExecutionRoleArn",
        .widget_date_range_override = "widgetDateRangeOverride",
        .widget_ids = "widgetIds",
    };
};

pub const UpdateScheduledReportOutput = struct {
    /// The ARN of the updated scheduled report.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScheduledReportInput, options: CallOptions) !UpdateScheduledReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-dashboards", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScheduledReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-dashboards", "BCM Dashboards", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMDashboardsService.UpdateScheduledReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScheduledReportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateScheduledReportOutput, body, allocator);
}
