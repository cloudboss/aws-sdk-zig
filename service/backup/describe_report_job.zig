const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportJob = @import("report_job.zig").ReportJob;

pub const DescribeReportJobInput = struct {
    /// The identifier of the report job. A unique, randomly generated, Unicode,
    /// UTF-8 encoded
    /// string that is at most 1,024 bytes long. The report job ID cannot be edited.
    report_job_id: []const u8,

    pub const json_field_names = .{
        .report_job_id = "ReportJobId",
    };
};

pub const DescribeReportJobOutput = struct {
    /// The information about a report job, including its completion and creation
    /// times,
    /// report destination, unique report job ID, Amazon Resource Name (ARN), report
    /// template,
    /// status, and status message.
    report_job: ?ReportJob = null,

    pub const json_field_names = .{
        .report_job = "ReportJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReportJobInput, options: CallOptions) !DescribeReportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/report-jobs/");
    try path_buf.appendSlice(allocator, input.report_job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReportJobOutput {
    const result: DescribeReportJobOutput = try aws.json.parseJsonObject(
        DescribeReportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
