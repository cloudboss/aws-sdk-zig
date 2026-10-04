const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const ScheduledReportInput = @import("scheduled_report_input.zig").ScheduledReportInput;

pub const CreateScheduledReportInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The tags to apply to the scheduled report resource for organization and
    /// management.
    resource_tags: ?[]const ResourceTag = null,

    /// The configuration for the scheduled report, including the dashboard to
    /// report on, the schedule, and the execution role that the service will use to
    /// generate the dashboard snapshot.
    scheduled_report: ScheduledReportInput,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .resource_tags = "resourceTags",
        .scheduled_report = "scheduledReport",
    };
};

pub const CreateScheduledReportOutput = struct {
    /// The ARN of the newly created scheduled report.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScheduledReportInput, options: CallOptions) !CreateScheduledReportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScheduledReportInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMDashboardsService.CreateScheduledReport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScheduledReportOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateScheduledReportOutput, body, allocator);
}
