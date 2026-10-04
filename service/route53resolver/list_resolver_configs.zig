const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResolverConfig = @import("resolver_config.zig").ResolverConfig;

pub const ListResolverConfigsInput = struct {
    /// The maximum number of Resolver configurations that you want to return in the
    /// response to
    /// a `ListResolverConfigs` request. If you don't specify a value for
    /// `MaxResults`,
    /// up to 100 Resolver configurations are returned.
    max_results: ?i32 = null,

    /// (Optional) If the current Amazon Web Services account has more than
    /// `MaxResults` Resolver configurations, use
    /// `NextToken` to get the second and subsequent pages of results.
    ///
    /// For the first `ListResolverConfigs` request, omit this value.
    ///
    /// For the second and subsequent requests, get the value of `NextToken` from
    /// the previous response and
    /// specify that value for `NextToken` in the request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListResolverConfigsOutput = struct {
    /// If a response includes the last of the Resolver configurations that are
    /// associated with the current Amazon Web Services account,
    /// `NextToken` doesn't appear in the response.
    ///
    /// If a response doesn't include the last of the configurations, you can get
    /// more configurations by submitting another
    /// `ListResolverConfigs` request.
    /// Get the value of `NextToken` that Amazon Route 53 returned in the previous
    /// response and include it in
    /// `NextToken` in the next request.
    next_token: ?[]const u8 = null,

    /// An array that contains one `ResolverConfigs` element for each Resolver
    /// configuration that is associated
    /// with the current Amazon Web Services account.
    resolver_configs: ?[]const ResolverConfig = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resolver_configs = "ResolverConfigs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResolverConfigsInput, options: CallOptions) !ListResolverConfigsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResolverConfigsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.ListResolverConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResolverConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListResolverConfigsOutput, body, allocator);
}
