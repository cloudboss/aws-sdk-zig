const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CspmConnectorStatus = @import("cspm_connector_status.zig").CspmConnectorStatus;
const CspmEnablementStatus = @import("cspm_enablement_status.zig").CspmEnablementStatus;
const CspmConnectorProviderName = @import("cspm_connector_provider_name.zig").CspmConnectorProviderName;
const CspmConnectorSummary = @import("cspm_connector_summary.zig").CspmConnectorSummary;

pub const ListConnectorsInput = struct {
    /// The connectivity status to filter connectors by.
    connector_status: ?CspmConnectorStatus = null,

    /// The enablement status to filter connectors by.
    enablement_status: ?CspmEnablementStatus = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The pagination token to request the next page of results.
    next_token: ?[]const u8 = null,

    /// The name of the cloud provider to filter connectors by.
    provider_name: ?CspmConnectorProviderName = null,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .enablement_status = "EnablementStatus",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .provider_name = "ProviderName",
    };
};

pub const ListConnectorsOutput = struct {
    /// An array of connector summaries.
    connectors: ?[]const CspmConnectorSummary = null,

    /// The pagination token to use to request the next page of results. If there
    /// are no additional results, this value is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connectors = "Connectors",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectorsInput, options: CallOptions) !ListConnectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connectors";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectorsOutput {
    const result: ListConnectorsOutput = try aws.json.parseJsonObject(
        ListConnectorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
