const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportDeliveryChannel = @import("report_delivery_channel.zig").ReportDeliveryChannel;
const ReportSetting = @import("report_setting.zig").ReportSetting;

pub const CreateReportPlanInput = struct {
    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `CreateReportPlanInput`. Retrying a successful request with the
    /// same
    /// idempotency token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    /// A structure that contains information about where and how to deliver your
    /// reports,
    /// specifically your Amazon S3 bucket name, S3 key prefix, and the formats of
    /// your
    /// reports.
    report_delivery_channel: ReportDeliveryChannel,

    /// An optional description of the report plan with a maximum of 1,024
    /// characters.
    report_plan_description: ?[]const u8 = null,

    /// The unique name of the report plan. The name must be between 1 and 256
    /// characters,
    /// starting with a letter, and consisting of letters (a-z, A-Z), numbers (0-9),
    /// and
    /// underscores (_).
    report_plan_name: []const u8,

    /// The tags to assign to the report plan.
    report_plan_tags: ?[]const aws.map.StringMapEntry = null,

    /// Identifies the report template for the report. Reports are built using a
    /// report
    /// template. The report templates are:
    ///
    /// `RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT | BACKUP_JOB_REPORT
    /// |
    /// COPY_JOB_REPORT | RESTORE_JOB_REPORT | SCAN_JOB_REPORT `
    ///
    /// If the report template is `RESOURCE_COMPLIANCE_REPORT` or
    /// `CONTROL_COMPLIANCE_REPORT`, this API resource also describes the report
    /// coverage by Amazon Web Services Regions and frameworks.
    report_setting: ReportSetting,

    pub const json_field_names = .{
        .idempotency_token = "IdempotencyToken",
        .report_delivery_channel = "ReportDeliveryChannel",
        .report_plan_description = "ReportPlanDescription",
        .report_plan_name = "ReportPlanName",
        .report_plan_tags = "ReportPlanTags",
        .report_setting = "ReportSetting",
    };
};

pub const CreateReportPlanOutput = struct {
    /// The date and time a backup vault is created, in Unix format and Coordinated
    /// Universal
    /// Time (UTC). The value of `CreationTime` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_time: ?i64 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    report_plan_arn: ?[]const u8 = null,

    /// The unique name of the report plan.
    report_plan_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .report_plan_arn = "ReportPlanArn",
        .report_plan_name = "ReportPlanName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReportPlanInput, options: CallOptions) !CreateReportPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReportPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/report-plans";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.idempotency_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdempotencyToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReportDeliveryChannel\":");
    try aws.json.writeValue(@TypeOf(input.report_delivery_channel), input.report_delivery_channel, allocator, &body_buf);
    has_prev = true;
    if (input.report_plan_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReportPlanDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReportPlanName\":");
    try aws.json.writeValue(@TypeOf(input.report_plan_name), input.report_plan_name, allocator, &body_buf);
    has_prev = true;
    if (input.report_plan_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReportPlanTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReportSetting\":");
    try aws.json.writeValue(@TypeOf(input.report_setting), input.report_setting, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReportPlanOutput {
    var result: CreateReportPlanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateReportPlanOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
