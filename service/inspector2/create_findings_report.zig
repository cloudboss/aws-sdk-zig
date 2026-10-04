const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FilterCriteria = @import("filter_criteria.zig").FilterCriteria;
const ReportFormat = @import("report_format.zig").ReportFormat;
const Destination = @import("destination.zig").Destination;

pub const CreateFindingsReportInput = struct {
    /// The filter criteria to apply to the results of the finding report.
    filter_criteria: ?FilterCriteria = null,

    /// The format to generate the report in.
    report_format: ReportFormat,

    /// The Amazon S3 export destination for the report.
    s_3_destination: Destination,

    pub const json_field_names = .{
        .filter_criteria = "filterCriteria",
        .report_format = "reportFormat",
        .s_3_destination = "s3Destination",
    };
};

pub const CreateFindingsReportOutput = struct {
    /// The ID of the report.
    report_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .report_id = "reportId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFindingsReportInput, options: CallOptions) !CreateFindingsReportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFindingsReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/reporting/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"reportFormat\":");
    try aws.json.writeValue(@TypeOf(input.report_format), input.report_format, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"s3Destination\":");
    try aws.json.writeValue(@TypeOf(input.s_3_destination), input.s_3_destination, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFindingsReportOutput {
    var result: CreateFindingsReportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFindingsReportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
