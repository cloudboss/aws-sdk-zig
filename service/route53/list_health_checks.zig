const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HealthCheck = @import("health_check.zig").HealthCheck;
const serde = @import("serde.zig");

pub const ListHealthChecksInput = struct {
    /// If the value of `IsTruncated` in the previous response was
    /// `true`, you have more health checks. To get another group, submit another
    /// `ListHealthChecks` request.
    ///
    /// For the value of `marker`, specify the value of `NextMarker`
    /// from the previous response, which is the ID of the first health check that
    /// Amazon Route
    /// 53 will return if you submit another request.
    ///
    /// If the value of `IsTruncated` in the previous response was
    /// `false`, there are no more health checks to get.
    marker: ?[]const u8 = null,

    /// The maximum number of health checks that you want `ListHealthChecks` to
    /// return in response to the current request. Amazon Route 53 returns a maximum
    /// of 1000
    /// items. If you set `MaxItems` to a value greater than 1000, Route 53 returns
    /// only the first 1000 health checks.
    max_items: ?i32 = null,
};

pub const ListHealthChecksOutput = struct {
    /// A complex type that contains one `HealthCheck` element for each health
    /// check that is associated with the current Amazon Web Services account.
    health_checks: ?[]const HealthCheck = null,

    /// A flag that indicates whether there are more health checks to be listed. If
    /// the
    /// response was truncated, you can get the next group of health checks by
    /// submitting
    /// another `ListHealthChecks` request and specifying the value of
    /// `NextMarker` in the `marker` parameter.
    is_truncated: ?bool = null,

    /// For the second and subsequent calls to `ListHealthChecks`,
    /// `Marker` is the value that you specified for the `marker`
    /// parameter in the previous request.
    marker: []const u8,

    /// The value that you specified for the `maxitems` parameter in the call to
    /// `ListHealthChecks` that produced the current response.
    max_items: i32,

    /// If `IsTruncated` is `true`, the value of `NextMarker`
    /// identifies the first health check that Amazon Route 53 returns if you submit
    /// another
    /// `ListHealthChecks` request and specify the value of
    /// `NextMarker` in the `marker` parameter.
    next_marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHealthChecksInput, options: CallOptions) !ListHealthChecksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHealthChecksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/healthcheck";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHealthChecksOutput {
    var result: ListHealthChecksOutput = undefined;
    result.next_marker = null;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HealthChecks")) {
                    result.health_checks = try serde.deserializeHealthChecks(allocator, &reader, "HealthCheck");
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
