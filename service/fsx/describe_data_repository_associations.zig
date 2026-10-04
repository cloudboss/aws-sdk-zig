const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DataRepositoryAssociation = @import("data_repository_association.zig").DataRepositoryAssociation;

pub const DescribeDataRepositoryAssociationsInput = struct {
    /// IDs of the data repository associations whose descriptions you want to
    /// retrieve
    /// (String).
    association_ids: ?[]const []const u8 = null,

    filters: ?[]const Filter = null,

    /// The maximum number of resources to return in the response. This value must
    /// be
    /// an integer greater than zero.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_ids = "AssociationIds",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeDataRepositoryAssociationsOutput = struct {
    /// An array of one or more data repository association descriptions.
    associations: ?[]const DataRepositoryAssociation = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .associations = "Associations",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataRepositoryAssociationsInput, options: CallOptions) !DescribeDataRepositoryAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataRepositoryAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DescribeDataRepositoryAssociations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataRepositoryAssociationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDataRepositoryAssociationsOutput, body, allocator);
}
