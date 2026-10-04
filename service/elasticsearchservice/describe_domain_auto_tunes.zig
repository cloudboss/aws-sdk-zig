const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoTune = @import("auto_tune.zig").AutoTune;

pub const DescribeDomainAutoTunesInput = struct {
    /// Specifies the domain name for which you want Auto-Tune action details.
    domain_name: []const u8,

    /// Set this value to limit the number of results returned. If not specified,
    /// defaults to 100.
    max_results: ?i32 = null,

    /// NextToken is sent in case the earlier API call results contain the
    /// NextToken. It is used for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeDomainAutoTunesOutput = struct {
    /// Specifies the list of setting adjustments that Auto-Tune has made to the
    /// domain. See the [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    auto_tunes: ?[]const AutoTune = null,

    /// Specifies an identifier to allow retrieval of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_tunes = "AutoTunes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainAutoTunesInput, options: CallOptions) !DescribeDomainAutoTunesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDomainAutoTunesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/autoTunes");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDomainAutoTunesOutput {
    const result: DescribeDomainAutoTunesOutput = try aws.json.parseJsonObject(
        DescribeDomainAutoTunesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
