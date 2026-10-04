const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const OutpostResolver = @import("outpost_resolver.zig").OutpostResolver;

pub const CreateOutpostResolverInput = struct {
    /// A unique string that identifies the request
    /// and that allows failed requests to be retried without the risk of running
    /// the operation twice.
    ///
    /// `CreatorRequestId` can be any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// Number of Amazon EC2 instances for the
    /// Resolver on Outpost.
    /// The default and minimal value is 4.
    instance_count: ?i32 = null,

    /// A friendly name that lets you easily find a configuration in the
    /// Resolver dashboard in the Route 53 console.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the Outpost. If you specify this, you must
    /// also specify a value for the `PreferredInstanceType`.
    outpost_arn: []const u8,

    /// The Amazon EC2 instance type. If you specify this, you must also specify a
    /// value for the `OutpostArn`.
    preferred_instance_type: []const u8,

    /// A string that helps identify the Route 53 Resolvers on Outpost.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .instance_count = "InstanceCount",
        .name = "Name",
        .outpost_arn = "OutpostArn",
        .preferred_instance_type = "PreferredInstanceType",
        .tags = "Tags",
    };
};

pub const CreateOutpostResolverOutput = struct {
    /// Information about the `CreateOutpostResolver`
    /// request, including the status of the request.
    outpost_resolver: ?OutpostResolver = null,

    pub const json_field_names = .{
        .outpost_resolver = "OutpostResolver",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOutpostResolverInput, options: CallOptions) !CreateOutpostResolverOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOutpostResolverInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.CreateOutpostResolver");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOutpostResolverOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOutpostResolverOutput, body, allocator);
}
