const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReportFormatType = @import("report_format_type.zig").ReportFormatType;

pub const GetCredentialReportInput = struct {};

pub const GetCredentialReportOutput = struct {
    /// Contains the credential report. The report is Base64-encoded.
    content: ?[]const u8 = null,

    /// The date and time when the credential report was created, in [ISO 8601
    /// date-time format](http://www.iso.org/iso/iso8601).
    generated_time: ?i64 = null,

    /// The format (MIME type) of the credential report.
    report_format: ?ReportFormatType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCredentialReportInput, options: CallOptions) !GetCredentialReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCredentialReportInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetCredentialReport&Version=2010-05-08");

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCredentialReportOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetCredentialReportResult")) break;
            },
            else => {},
        }
    }

    var result: GetCredentialReportOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Content")) {
                    result.content = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GeneratedTime")) {
                    result.generated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ReportFormat")) {
                    result.report_format = ReportFormatType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
