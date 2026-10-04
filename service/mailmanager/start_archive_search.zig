const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveFilters = @import("archive_filters.zig").ArchiveFilters;

pub const StartArchiveSearchInput = struct {
    /// The identifier of the archive to search emails in.
    archive_id: []const u8,

    /// Criteria to filter which emails are included in the search results.
    filters: ?ArchiveFilters = null,

    /// The start timestamp of the range to search emails from.
    from_timestamp: i64,

    /// The maximum number of search results to return.
    max_results: i32,

    /// The end timestamp of the range to search emails from.
    to_timestamp: i64,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
        .filters = "Filters",
        .from_timestamp = "FromTimestamp",
        .max_results = "MaxResults",
        .to_timestamp = "ToTimestamp",
    };
};

pub const StartArchiveSearchOutput = struct {
    /// The unique identifier for the initiated search job.
    search_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .search_id = "SearchId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartArchiveSearchInput, options: CallOptions) !StartArchiveSearchOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartArchiveSearchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.StartArchiveSearch");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartArchiveSearchOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartArchiveSearchOutput, body, allocator);
}
