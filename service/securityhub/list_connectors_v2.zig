const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;
const EnablementStatus = @import("enablement_status.zig").EnablementStatus;
const ConnectorProviderName = @import("connector_provider_name.zig").ConnectorProviderName;
const ConnectorSummary = @import("connector_summary.zig").ConnectorSummary;

pub const ListConnectorsV2Input = struct {
    /// The status for the connectorV2.
    connector_status: ?ConnectorStatus = null,

    /// The enablement status to filter connectors by.
    enablement_status: ?EnablementStatus = null,

    /// The maximum number of results to be returned.
    max_results: ?i32 = null,

    /// The pagination token per the Amazon Web Services Pagination standard
    next_token: ?[]const u8 = null,

    /// The name of the third-party provider.
    provider_name: ?ConnectorProviderName = null,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .enablement_status = "EnablementStatus",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .provider_name = "ProviderName",
    };
};

pub const ListConnectorsV2Output = struct {
    /// An array of connectorV2 summaries.
    connectors: ?[]const ConnectorSummary = null,

    /// The pagination token to use to request the next page of results.
    /// Otherwise, this parameter is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connectors = "Connectors",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectorsV2Input, options: CallOptions) !ListConnectorsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectorsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connectorsv2";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.connector_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ConnectorStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.enablement_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "EnablementStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.provider_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ProviderName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectorsV2Output {
    const result: ListConnectorsV2Output = try aws.json.parseJsonObject(
        ListConnectorsV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
