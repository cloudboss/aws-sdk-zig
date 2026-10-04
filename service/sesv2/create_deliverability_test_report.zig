const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EmailContent = @import("email_content.zig").EmailContent;
const Tag = @import("tag.zig").Tag;
const DeliverabilityTestStatus = @import("deliverability_test_status.zig").DeliverabilityTestStatus;

pub const CreateDeliverabilityTestReportInput = struct {
    /// The HTML body of the message that you sent when you performed the predictive
    /// inbox placement test.
    content: EmailContent,

    /// The email address that the predictive inbox placement test email was sent
    /// from.
    from_email_address: []const u8,

    /// A unique name that helps you to identify the predictive inbox placement test
    /// when you retrieve the
    /// results.
    report_name: ?[]const u8 = null,

    /// An array of objects that define the tags (keys and values) that you want to
    /// associate
    /// with the predictive inbox placement test.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .content = "Content",
        .from_email_address = "FromEmailAddress",
        .report_name = "ReportName",
        .tags = "Tags",
    };
};

pub const CreateDeliverabilityTestReportOutput = struct {
    /// The status of the predictive inbox placement test. If the status is
    /// `IN_PROGRESS`, then the predictive inbox placement test
    /// is currently running. Predictive inbox placement tests are usually complete
    /// within 24 hours of creating the
    /// test. If the status is `COMPLETE`, then the test is finished, and you can
    /// use
    /// the `GetDeliverabilityTestReport` to view the results of the test.
    deliverability_test_status: DeliverabilityTestStatus,

    /// A unique string that identifies the predictive inbox placement test.
    report_id: []const u8,

    pub const json_field_names = .{
        .deliverability_test_status = "DeliverabilityTestStatus",
        .report_id = "ReportId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeliverabilityTestReportInput, options: CallOptions) !CreateDeliverabilityTestReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeliverabilityTestReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/deliverability-dashboard/test";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FromEmailAddress\":");
    try aws.json.writeValue(@TypeOf(input.from_email_address), input.from_email_address, allocator, &body_buf);
    has_prev = true;
    if (input.report_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReportName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeliverabilityTestReportOutput {
    const result: CreateDeliverabilityTestReportOutput = try aws.json.parseJsonObject(
        CreateDeliverabilityTestReportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
