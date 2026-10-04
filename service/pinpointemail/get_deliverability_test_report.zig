const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliverabilityTestReport = @import("deliverability_test_report.zig").DeliverabilityTestReport;
const IspPlacement = @import("isp_placement.zig").IspPlacement;
const PlacementStatistics = @import("placement_statistics.zig").PlacementStatistics;
const Tag = @import("tag.zig").Tag;

pub const GetDeliverabilityTestReportInput = struct {
    /// A unique string that identifies the predictive inbox placement test.
    report_id: []const u8,

    pub const json_field_names = .{
        .report_id = "ReportId",
    };
};

pub const GetDeliverabilityTestReportOutput = struct {
    /// An object that contains the results of the predictive inbox placement test.
    deliverability_test_report: ?DeliverabilityTestReport = null,

    /// An object that describes how the test email was handled by several email
    /// providers,
    /// including Gmail, Hotmail, Yahoo, AOL, and others.
    isp_placements: ?[]const IspPlacement = null,

    /// An object that contains the message that you sent when you performed this
    /// predictive inbox placement test.
    message: ?[]const u8 = null,

    /// An object that specifies how many test messages that were sent during the
    /// predictive inbox placement test were
    /// delivered to recipients' inboxes, how many were sent to recipients' spam
    /// folders, and
    /// how many weren't delivered.
    overall_placement: ?PlacementStatistics = null,

    /// An array of objects that define the tags (keys and values) that are
    /// associated with
    /// the predictive inbox placement test.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .deliverability_test_report = "DeliverabilityTestReport",
        .isp_placements = "IspPlacements",
        .message = "Message",
        .overall_placement = "OverallPlacement",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeliverabilityTestReportInput, options: CallOptions) !GetDeliverabilityTestReportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeliverabilityTestReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/deliverability-dashboard/test-reports/");
    try path_buf.appendSlice(allocator, input.report_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeliverabilityTestReportOutput {
    var result: GetDeliverabilityTestReportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDeliverabilityTestReportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
