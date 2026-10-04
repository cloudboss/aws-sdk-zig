const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NeighborConnectionDetail = @import("neighbor_connection_detail.zig").NeighborConnectionDetail;

pub const ListServerNeighborsInput = struct {
    /// Configuration ID of the server for which neighbors are being listed.
    configuration_id: []const u8,

    /// Maximum number of results to return in a single page of output.
    max_results: ?i32 = null,

    /// List of configuration IDs to test for one-hop-away.
    neighbor_configuration_ids: ?[]const []const u8 = null,

    /// Token to retrieve the next set of results. For example, if you previously
    /// specified 100
    /// IDs for `ListServerNeighborsRequest$neighborConfigurationIds` but set
    /// `ListServerNeighborsRequest$maxResults` to 10, you received a set of 10
    /// results
    /// along with a token. Use that token in this query to get the next set of 10.
    next_token: ?[]const u8 = null,

    /// Flag to indicate if port and protocol information is needed as part of the
    /// response.
    port_information_needed: ?bool = null,

    pub const json_field_names = .{
        .configuration_id = "configurationId",
        .max_results = "maxResults",
        .neighbor_configuration_ids = "neighborConfigurationIds",
        .next_token = "nextToken",
        .port_information_needed = "portInformationNeeded",
    };
};

pub const ListServerNeighborsOutput = struct {
    /// Count of distinct servers that are one hop away from the given server.
    known_dependency_count: ?i64 = null,

    /// List of distinct servers that are one hop away from the given server.
    neighbors: ?[]const NeighborConnectionDetail = null,

    /// Token to retrieve the next set of results. For example, if you specified 100
    /// IDs for
    /// `ListServerNeighborsRequest$neighborConfigurationIds` but set
    /// `ListServerNeighborsRequest$maxResults` to 10, you received a set of 10
    /// results
    /// along with this token. Use this token in the next query to retrieve the next
    /// set of
    /// 10.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .known_dependency_count = "knownDependencyCount",
        .neighbors = "neighbors",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServerNeighborsInput, options: CallOptions) !ListServerNeighborsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServerNeighborsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.ListServerNeighbors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServerNeighborsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListServerNeighborsOutput, body, allocator);
}
