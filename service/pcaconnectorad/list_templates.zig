const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateSummary = @import("template_summary.zig").TemplateSummary;

pub const ListTemplatesInput = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called
    /// [CreateConnector](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateConnector.html).
    connector_arn: []const u8,

    /// Use this parameter when paginating results to specify the maximum number of
    /// items to
    /// return in the response on each page. If additional items exist beyond the
    /// number you
    /// specify, the `NextToken` element is sent in the response. Use this
    /// `NextToken` value in a subsequent request to retrieve additional
    /// items.
    max_results: ?i32 = null,

    /// Use this parameter when paginating results in a subsequent request after you
    /// receive a
    /// response with truncated results. Set it to the value of the `NextToken`
    /// parameter from the response you just received.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTemplatesOutput = struct {
    /// Use this parameter when paginating results in a subsequent request after you
    /// receive a
    /// response with truncated results. Set it to the value of the `NextToken`
    /// parameter from the response you just received.
    next_token: ?[]const u8 = null,

    /// Custom configuration templates used when issuing a certificate.
    templates: ?[]const TemplateSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .templates = "Templates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTemplatesInput, options: CallOptions) !ListTemplatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pca-connector-ad", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTemplatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pca-connector-ad", "Pca Connector Ad", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/templates";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "ConnectorArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.connector_arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTemplatesOutput {
    var result: ListTemplatesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTemplatesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
