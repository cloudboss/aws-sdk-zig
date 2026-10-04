const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeProgressStatusDetails = @import("change_progress_status_details.zig").ChangeProgressStatusDetails;

pub const DescribeDomainChangeProgressInput = struct {
    /// The specific change ID for which you want to get progress information. This
    /// is an optional parameter.
    /// If omitted, the service returns information about the most recent
    /// configuration change.
    change_id: ?[]const u8 = null,

    /// The domain you want to get the progress information about.
    domain_name: []const u8,

    pub const json_field_names = .{
        .change_id = "ChangeId",
        .domain_name = "DomainName",
    };
};

pub const DescribeDomainChangeProgressOutput = struct {
    /// Progress information for the configuration change that is requested in the
    /// `DescribeDomainChangeProgress` request.
    change_progress_status: ?ChangeProgressStatusDetails = null,

    pub const json_field_names = .{
        .change_progress_status = "ChangeProgressStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainChangeProgressInput, options: CallOptions) !DescribeDomainChangeProgressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDomainChangeProgressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/progress");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.change_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "changeid=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDomainChangeProgressOutput {
    const result: DescribeDomainChangeProgressOutput = try aws.json.parseJsonObject(
        DescribeDomainChangeProgressOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
