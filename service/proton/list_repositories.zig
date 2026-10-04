const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositorySummary = @import("repository_summary.zig").RepositorySummary;

pub const ListRepositoriesInput = struct {
    /// The maximum number of repositories to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next repository in the array of
    /// repositories, after the list of repositories previously requested.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListRepositoriesOutput = struct {
    /// A token that indicates the location of the next repository in the array of
    /// repositories, after the current requested list of repositories.
    next_token: ?[]const u8 = null,

    /// An array of repository links.
    repositories: ?[]const RepositorySummary = null,

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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListRepositories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRepositoriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListRepositoriesOutput, body, allocator);
}
