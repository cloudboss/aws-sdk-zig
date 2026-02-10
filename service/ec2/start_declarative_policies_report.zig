const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;

/// Generates an account status report. The report is generated asynchronously,
/// and can
/// take several hours to complete.
///
/// The report provides the current status of all attributes supported by
/// declarative
/// policies for the accounts within the specified scope. The scope is
/// determined by the
/// specified `TargetId`, which can represent an individual account, or all the
/// accounts that fall under the specified organizational unit (OU) or root (the
/// entire
/// Amazon Web Services Organization).
///
/// The report is saved to your specified S3 bucket, using the following path
/// structure
/// (with the capitalized placeholders representing your specific values):
///
/// `s3://AMZN-S3-DEMO-BUCKET/YOUR-OPTIONAL-S3-PREFIX/ec2_TARGETID_REPORTID_YYYYMMDDTHHMMZ.csv`
///
/// **Prerequisites for generating a report**
///
/// * The `StartDeclarativePoliciesReport` API can only be called by the
/// management account or delegated administrators for the organization.
///
/// * An S3 bucket must be available before generating the report (you can
///   create a
/// new one or use an existing one), it must be in the same Region where the
/// report
/// generation request is made, and it must have an appropriate bucket policy.
/// For a
/// sample S3 policy, see *Sample Amazon S3 policy* under
/// [Examples](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StartDeclarativePoliciesReport.html#API_StartDeclarativePoliciesReport_Examples).
///
/// * Trusted access must be enabled for the service for which the declarative
/// policy will enforce a baseline configuration. If you use the Amazon Web
/// Services Organizations
/// console, this is done automatically when you enable declarative policies.
/// The
/// API uses the following service principal to identify the EC2 service:
/// `ec2.amazonaws.com`. For more information on how to enable
/// trusted access with the Amazon Web Services CLI and Amazon Web Services
/// SDKs, see [Using
/// Organizations with other Amazon Web Services
/// services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) in the
/// *Amazon Web Services Organizations User Guide*.
///
/// * Only one report per organization can be generated at a time. Attempting to
/// generate a report while another is in progress will result in an error.
///
/// For more information, including the required IAM permissions to run this
/// API, see
/// [Generating the account status report for declarative
/// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative_status-report.html) in the
/// *Amazon Web Services Organizations User Guide*.
pub const StartDeclarativePoliciesReportInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The name of the S3 bucket where the report will be saved. The bucket must be
    /// in the
    /// same Region where the report generation request is made.
    s_3_bucket: []const u8,

    /// The prefix for your S3 object.
    s_3_prefix: ?[]const u8 = null,

    /// The tags to apply.
    tag_specifications: ?[]const TagSpecification = null,

    /// The root ID, organizational unit ID, or account ID.
    ///
    /// Format:
    ///
    /// * For root: `r-ab12`
    ///
    /// * For OU: `ou-ab12-cdef1234`
    ///
    /// * For account: `123456789012`
    target_id: []const u8,
};

pub const StartDeclarativePoliciesReportOutput = struct {
    /// The ID of the report.
    report_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const StartDeclarativePoliciesReportOutput) void {
        if (self.report_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: StartDeclarativePoliciesReportInput, options: Options) !StartDeclarativePoliciesReportOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartDeclarativePoliciesReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=StartDeclarativePoliciesReport&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&S3Bucket=");
    try appendUrlEncoded(alloc, &body_buf, input.s_3_bucket);
    if (input.s_3_prefix) |v| {
        try body_buf.appendSlice(alloc, "&S3Prefix=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&TargetId=");
    try appendUrlEncoded(alloc, &body_buf, input.target_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !StartDeclarativePoliciesReportOutput {
    _ = status;
    var result: StartDeclarativePoliciesReportOutput = .{ .allocator = alloc };
    if (findElement(body, "reportId")) |content| {
        result.report_id = try alloc.dupe(u8, content);
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
