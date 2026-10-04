const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const summaryStateType = @import("summary_state_type.zig").summaryStateType;

pub const GetHumanReadableSummaryInput = struct {
    /// Arn of the entity to be summarized. At this time, the only supported
    /// entity type is `delegation-request`
    entity_arn: []const u8,

    /// A string representing the locale to use for the summary generation. The
    /// supported locale strings are based on the [
    /// Supported languages of the Amazon Web Services Management Console
    /// ](/awsconsolehelpdocs/latest/gsg/change-language.html#supported-languages).
    locale: ?[]const u8 = null,
};

pub const GetHumanReadableSummaryOutput = struct {
    /// The locale that this response was generated for. This maps to the input
    /// locale.
    locale: ?[]const u8 = null,

    /// Summary content in the specified locale. Summary content is non-empty only
    /// if the
    /// `SummaryState` is `AVAILABLE`.
    summary_content: ?[]const u8 = null,

    /// State of summary generation. This generation process is asynchronous and
    /// this attribute indicates the
    /// state of the generation process.
    summary_state: ?summaryStateType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHumanReadableSummaryInput, options: CallOptions) !GetHumanReadableSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetHumanReadableSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetHumanReadableSummary&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&EntityArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.entity_arn);
    if (input.locale) |v| {
        try body_buf.appendSlice(allocator, "&Locale=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetHumanReadableSummaryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetHumanReadableSummaryResult")) break;
            },
            else => {},
        }
    }

    var result: GetHumanReadableSummaryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Locale")) {
                    result.locale = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SummaryContent")) {
                    result.summary_content = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SummaryState")) {
                    result.summary_state = summaryStateType.fromWireName(try reader.readElementText());
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
