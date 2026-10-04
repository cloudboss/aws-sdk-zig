const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HandshakeFilter = @import("handshake_filter.zig").HandshakeFilter;
const Handshake = @import("handshake.zig").Handshake;

pub const ListHandshakesForOrganizationInput = struct {
    /// A `HandshakeFilter` object. Contains the filer used to select the
    /// handshakes for an operation.
    filter: ?HandshakeFilter = null,

    /// The maximum number of items to return in the response. If more results exist
    /// than the specified `MaxResults` value, a token is included in the response
    /// so that you can retrieve the remaining results.
    max_results: ?i32 = null,

    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken` response
    /// indicates that more output is available. Set this parameter to the value of
    /// the previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListHandshakesForOrganizationOutput = struct {
    /// An array of `Handshake`objects. Contains details for a handshake.
    handshakes: ?[]const Handshake = null,

    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .handshakes = "Handshakes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHandshakesForOrganizationInput, options: CallOptions) !ListHandshakesForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHandshakesForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.ListHandshakesForOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHandshakesForOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListHandshakesForOrganizationOutput, body, allocator);
}
