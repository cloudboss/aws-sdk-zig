const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const ReportingErrorCode = @import("reporting_error_code.zig").ReportingErrorCode;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const ExternalReportStatus = @import("external_report_status.zig").ExternalReportStatus;

pub const GetFindingsReportStatusInput = struct {
    /// The ID of the report to retrieve the status of.
    report_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .report_id = "reportId",
    };
};

pub const GetFindingsReportStatusOutput = struct {
    /// The destination of the report.
    destination: ?Destination = null,

    /// The error code of the report.
    error_code: ?ReportingErrorCode = null,

    /// The error message of the report.
    error_message: ?[]const u8 = null,

    /// The filter criteria associated with the report.
    filter_criteria: ?FilterCriteria = null,

    /// The ID of the report.
    report_id: ?[]const u8 = null,

    /// The status of the report.
    status: ?ExternalReportStatus = null,

    pub const json_field_names = .{
        .destination = "destination",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .filter_criteria = "filterCriteria",
        .report_id = "reportId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingsReportStatusInput, options: CallOptions) !GetFindingsReportStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingsReportStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/reporting/status/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.report_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reportId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingsReportStatusOutput {
    const result: GetFindingsReportStatusOutput = try aws.json.parseJsonObject(
        GetFindingsReportStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
