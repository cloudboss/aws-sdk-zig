const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceSummary = @import("instance_summary.zig").InstanceSummary;

pub const ListInstancesInput = struct {
    /// The maximum number of instances that you want Cloud Map to return in the
    /// response to a
    /// `ListInstances` request. If you don't specify a value for `MaxResults`,
    /// Cloud Map returns up to 100 instances.
    max_results: ?i32 = null,

    /// For the first `ListInstances` request, omit this value.
    ///
    /// If more than `MaxResults` instances match the specified criteria, you can
    /// submit
    /// another `ListInstances` request to get the next group of results. Specify
    /// the value of
    /// `NextToken` from the previous response in the next request.
    next_token: ?[]const u8 = null,

    /// The ID or Amazon Resource Name (ARN) of the service that you want to list
    /// instances for. For services created
    /// in a shared namespace, specify the service ARN. For more information about
    /// shared namespaces,
    /// see [Cross-account
    /// Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    service_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_id = "ServiceId",
    };
};

pub const ListInstancesOutput = struct {
    /// Summary information about the instances that are associated with the
    /// specified
    /// service.
    instances: ?[]const InstanceSummary = null,

    /// If more than `MaxResults` instances match the specified criteria, you can
    /// submit
    /// another `ListInstances` request to get the next group of results. Specify
    /// the value of
    /// `NextToken` from the previous response in the next request.
    next_token: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that created the namespace that
    /// contains the specified service.
    /// If this isn't your account ID, it's the ID of the account that shared the
    /// namespace with your
    /// account.
    resource_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .instances = "Instances",
        .next_token = "NextToken",
        .resource_owner = "ResourceOwner",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInstancesInput, options: CallOptions) !ListInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicediscovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.ListInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInstancesOutput, body, allocator);
}
