const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLoggingConfig = @import("query_logging_config.zig").QueryLoggingConfig;
const serde = @import("serde.zig");

pub const ListQueryLoggingConfigsInput = struct {
    /// (Optional) If you want to list the query logging configuration that is
    /// associated with
    /// a hosted zone, specify the ID in `HostedZoneId`.
    ///
    /// If you don't specify a hosted zone ID, `ListQueryLoggingConfigs` returns
    /// all of the configurations that are associated with the current Amazon Web
    /// Services account.
    hosted_zone_id: ?[]const u8 = null,

    /// (Optional) The maximum number of query logging configurations that you want
    /// Amazon
    /// Route 53 to return in response to the current request. If the current Amazon
    /// Web Services account has more than `MaxResults` configurations, use the
    /// value of
    /// [NextToken](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListQueryLoggingConfigs.html#API_ListQueryLoggingConfigs_RequestSyntax) in the response to get the next page of results.
    ///
    /// If you don't specify a value for `MaxResults`, Route 53 returns up to 100
    /// configurations.
    max_results: ?i32 = null,

    /// (Optional) If the current Amazon Web Services account has more than
    /// `MaxResults` query logging configurations, use `NextToken` to
    /// get the second and subsequent pages of results.
    ///
    /// For the first `ListQueryLoggingConfigs` request, omit this value.
    ///
    /// For the second and subsequent requests, get the value of `NextToken` from
    /// the previous response and specify that value for `NextToken` in the
    /// request.
    next_token: ?[]const u8 = null,
};

pub const ListQueryLoggingConfigsOutput = struct {
    /// If a response includes the last of the query logging configurations that are
    /// associated with the current Amazon Web Services account, `NextToken` doesn't
    /// appear in the response.
    ///
    /// If a response doesn't include the last of the configurations, you can get
    /// more
    /// configurations by submitting another
    /// [ListQueryLoggingConfigs](https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListQueryLoggingConfigs.html) request. Get the value of `NextToken`
    /// that Amazon Route 53 returned in the previous response and include it in
    /// `NextToken` in the next request.
    next_token: ?[]const u8 = null,

    /// An array that contains one
    /// [QueryLoggingConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_QueryLoggingConfig.html) element for each configuration for DNS query logging
    /// that is associated with the current Amazon Web Services account.
    query_logging_configs: ?[]const QueryLoggingConfig = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQueryLoggingConfigsInput, options: CallOptions) !ListQueryLoggingConfigsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQueryLoggingConfigsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/queryloggingconfig";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.hosted_zone_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "hostedzoneid=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxresults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nexttoken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQueryLoggingConfigsOutput {
    var result: ListQueryLoggingConfigsOutput = undefined;
    result.next_token = null;
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
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "QueryLoggingConfigs")) {
                    result.query_logging_configs = try serde.deserializeQueryLoggingConfigs(allocator, &reader, "QueryLoggingConfig");
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
