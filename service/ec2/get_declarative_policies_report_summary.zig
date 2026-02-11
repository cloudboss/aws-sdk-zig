const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeSummary = @import("attribute_summary.zig").AttributeSummary;

/// Retrieves a summary of the account status report.
///
/// To view the full report, download it from the Amazon S3 bucket where it was
/// saved.
/// Reports are accessible only when they have the `complete` status. Reports
/// with other statuses (`running`, `cancelled`, or
/// `error`) are not available in the S3 bucket. For more information about
/// downloading objects from an S3 bucket, see [Downloading
/// objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/download-objects.html) in
/// the *Amazon Simple Storage Service User Guide*.
///
/// For more information, see [Generating the account status report for
/// declarative
/// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative_status-report.html) in the
/// *Amazon Web Services Organizations User Guide*.
pub const GetDeclarativePoliciesReportSummaryInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the report.
    report_id: []const u8,
};

pub const GetDeclarativePoliciesReportSummaryOutput = struct {
    /// The attributes described in the report.
    attribute_summaries: ?[]const AttributeSummary = null,

    /// The time when the report generation ended.
    end_time: ?i64 = null,

    /// The total number of accounts associated with the specified
    /// `targetId`.
    number_of_accounts: ?i32 = null,

    /// The number of accounts where attributes could not be retrieved in any
    /// Region.
    number_of_failed_accounts: ?i32 = null,

    /// The ID of the report.
    report_id: ?[]const u8 = null,

    /// The name of the Amazon S3 bucket where the report is located.
    s_3_bucket: ?[]const u8 = null,

    /// The prefix for your S3 object.
    s_3_prefix: ?[]const u8 = null,

    /// The time when the report generation started.
    start_time: ?i64 = null,

    /// The root ID, organizational unit ID, or account ID.
    ///
    /// Format:
    ///
    /// * For root: `r-ab12`
    ///
    /// * For OU: `ou-ab12-cdef1234`
    ///
    /// * For account: `123456789012`
    target_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GetDeclarativePoliciesReportSummaryOutput) void {
        if (self.report_id) |v| {
            self.allocator.free(v);
        }
        if (self.s_3_bucket) |v| {
            self.allocator.free(v);
        }
        if (self.s_3_prefix) |v| {
            self.allocator.free(v);
        }
        if (self.target_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetDeclarativePoliciesReportSummaryInput, options: Options) !GetDeclarativePoliciesReportSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetDeclarativePoliciesReportSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetDeclarativePoliciesReportSummary&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ReportId=");
    try appendUrlEncoded(alloc, &body_buf, input.report_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetDeclarativePoliciesReportSummaryOutput {
    _ = status;
    _ = headers;
    var result: GetDeclarativePoliciesReportSummaryOutput = .{ .allocator = alloc };
    if (findElement(body, "endTime")) |content| {
        result.end_time = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findElement(body, "numberOfAccounts")) |content| {
        result.number_of_accounts = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "numberOfFailedAccounts")) |content| {
        result.number_of_failed_accounts = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "reportId")) |content| {
        result.report_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "s3Bucket")) |content| {
        result.s_3_bucket = try alloc.dupe(u8, content);
    }
    if (findElement(body, "s3Prefix")) |content| {
        result.s_3_prefix = try alloc.dupe(u8, content);
    }
    if (findElement(body, "startTime")) |content| {
        result.start_time = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findElement(body, "targetId")) |content| {
        result.target_id = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
