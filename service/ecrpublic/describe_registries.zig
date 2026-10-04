const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Registry = @import("registry.zig").Registry;

pub const DescribeRegistriesInput = struct {
    /// The maximum number of repository results that's returned by
    /// `DescribeRegistries` in paginated output. When this parameter is used,
    /// `DescribeRegistries` only returns `maxResults` results in a single
    /// page along with a `nextToken` response element. The remaining results of the
    /// initial request can be seen by sending another `DescribeRegistries` request
    /// with
    /// the returned `nextToken` value. This value can be between 1 and
    /// 1000. If this parameter isn't used, then `DescribeRegistries`
    /// returns up to 100 results and a `nextToken` value, if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value that's returned from a previous paginated
    /// `DescribeRegistries` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value. If there are no more
    /// results to return, this value is `null`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeRegistriesOutput = struct {
    /// The `nextToken` value to include in a future
    /// `DescribeRepositories` request. If the results of a
    /// `DescribeRepositories` request exceed `maxResults`, you can use
    /// this value to retrieve the next page of results. If there are no more
    /// results, this value
    /// is `null`.
    next_token: ?[]const u8 = null,

    /// An object that contains the details for a public registry.
    registries: ?[]const Registry = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .registries = "registries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRegistriesInput, options: CallOptions) !DescribeRegistriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr-public", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRegistriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr-public", "ECR PUBLIC", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.DescribeRegistries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRegistriesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRegistriesOutput, body, allocator);
}
