const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartnerEventSource = @import("partner_event_source.zig").PartnerEventSource;

pub const ListPartnerEventSourcesInput = struct {
    /// pecifying this limits the number of results returned by this operation. The
    /// operation also
    /// returns a NextToken which you can use in a subsequent operation to retrieve
    /// the next set of
    /// results.
    limit: ?i32 = null,

    /// If you specify this, the results are limited to only those partner event
    /// sources that
    /// start with the string you specify.
    name_prefix: []const u8,

    /// The token returned by a previous call to this operation. Specifying this
    /// retrieves the
    /// next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .name_prefix = "NamePrefix",
        .next_token = "NextToken",
    };
};

pub const ListPartnerEventSourcesOutput = struct {
    /// A token you can use in a subsequent operation to retrieve the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// The list of partner event sources returned by the operation.
    partner_event_sources: ?[]const PartnerEventSource = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .partner_event_sources = "PartnerEventSources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPartnerEventSourcesInput, options: CallOptions) !ListPartnerEventSourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPartnerEventSourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.ListPartnerEventSources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPartnerEventSourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPartnerEventSourcesOutput, body, allocator);
}
