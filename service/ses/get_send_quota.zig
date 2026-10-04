const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSendQuotaInput = struct {};

pub const GetSendQuotaOutput = struct {
    /// The maximum number of emails the user is allowed to send in a 24-hour
    /// interval. A
    /// value of -1 signifies an unlimited quota.
    max_24_hour_send: ?f64 = null,

    /// The maximum number of emails that Amazon SES can accept from the user's
    /// account per
    /// second.
    ///
    /// The rate at which Amazon SES accepts the user's messages might be less than
    /// the maximum
    /// send rate.
    max_send_rate: ?f64 = null,

    /// The number of emails sent during the previous 24 hours.
    sent_last_24_hours: ?f64 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSendQuotaInput, options: CallOptions) !GetSendQuotaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSendQuotaInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetSendQuota&Version=2010-12-01");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSendQuotaOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetSendQuotaResult")) break;
            },
            else => {},
        }
    }

    var result: GetSendQuotaOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Max24HourSend")) {
                    result.max_24_hour_send = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxSendRate")) {
                    result.max_send_rate = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SentLast24Hours")) {
                    result.sent_last_24_hours = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
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
