const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrderEnum = @import("order_enum.zig").OrderEnum;
const SortByEnum = @import("sort_by_enum.zig").SortByEnum;
const RepositoryNameIdPair = @import("repository_name_id_pair.zig").RepositoryNameIdPair;

pub const ListRepositoriesInput = struct {
    /// An enumeration token that allows the operation to batch the results of the
    /// operation.
    /// Batch sizes are 1,000 for list repository operations. When the client sends
    /// the token back to CodeCommit,
    /// another page of 1,000 records is retrieved.
    next_token: ?[]const u8 = null,

    /// The order in which to sort the results of a list repositories operation.
    order: ?OrderEnum = null,

    /// The criteria used to sort the results of a list repositories operation.
    sort_by: ?SortByEnum = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .order = "order",
        .sort_by = "sortBy",
    };
};

pub const ListRepositoriesOutput = struct {
    /// An enumeration token that allows the operation to batch the results of the
    /// operation.
    /// Batch sizes are 1,000 for list repository operations. When the client sends
    /// the token back to CodeCommit,
    /// another page of 1,000 records is retrieved.
    next_token: ?[]const u8 = null,

    /// Lists the repositories called by the list repositories operation.
    repositories: ?[]const RepositoryNameIdPair = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .repositories = "repositories",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRepositoriesInput, options: CallOptions) !ListRepositoriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRepositoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.ListRepositories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRepositoriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListRepositoriesOutput, body, allocator);
}
