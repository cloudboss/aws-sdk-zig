const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DashboardEntry = @import("dashboard_entry.zig").DashboardEntry;
const serde = @import("serde.zig");

pub const ListDashboardsInput = struct {
    /// If you specify this parameter, only the dashboards with names starting with
    /// the
    /// specified string are listed. The maximum length is 255, and valid characters
    /// are A-Z,
    /// a-z, 0-9, ".", "-", and "_".
    dashboard_name_prefix: ?[]const u8 = null,

    /// The token returned by a previous call to indicate that there is more data
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_name_prefix = "DashboardNamePrefix",
        .next_token = "NextToken",
    };
};

pub const ListDashboardsOutput = struct {
    /// The list of matching dashboards.
    dashboard_entries: ?[]const DashboardEntry = null,

    /// The token that marks the start of the next batch of returned results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dashboard_entries = "DashboardEntries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDashboardsInput, options: CallOptions) !ListDashboardsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDashboardsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListDashboards&Version=2010-08-01");
    if (input.dashboard_name_prefix) |v| {
        try body_buf.appendSlice(allocator, "&DashboardNamePrefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDashboardsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListDashboardsResult")) break;
            },
            else => {},
        }
    }

    var result: ListDashboardsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DashboardEntries")) {
                    result.dashboard_entries = try serde.deserializeDashboardEntries(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
