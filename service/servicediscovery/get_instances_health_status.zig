const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HealthStatus = @import("health_status.zig").HealthStatus;

pub const GetInstancesHealthStatusInput = struct {
    /// An array that contains the IDs of all the instances that you want to get the
    /// health status
    /// for.
    ///
    /// If you omit `Instances`, Cloud Map returns the health status for all the
    /// instances that are associated with the specified service.
    ///
    /// To get the IDs for the instances that you've registered by using a specified
    /// service,
    /// submit a
    /// [ListInstances](https://docs.aws.amazon.com/cloud-map/latest/api/API_ListInstances.html) request.
    instances: ?[]const []const u8 = null,

    /// The maximum number of instances that you want Cloud Map to return in the
    /// response to a
    /// `GetInstancesHealthStatus` request. If you don't specify a value for
    /// `MaxResults`, Cloud Map returns up to 100 instances.
    max_results: ?i32 = null,

    /// For the first `GetInstancesHealthStatus` request, omit this value.
    ///
    /// If more than `MaxResults` instances match the specified criteria, you can
    /// submit
    /// another `GetInstancesHealthStatus` request to get the next group of results.
    /// Specify
    /// the value of `NextToken` from the previous response in the next request.
    next_token: ?[]const u8 = null,

    /// The ID or Amazon Resource Name (ARN) of the service that the instance is
    /// associated with. For services
    /// created in a shared namespace, specify the service ARN. For more information
    /// about shared
    /// namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    service_id: []const u8,

    pub const json_field_names = .{
        .instances = "Instances",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_id = "ServiceId",
    };
};

pub const GetInstancesHealthStatusOutput = struct {
    /// If more than `MaxResults` instances match the specified criteria, you can
    /// submit
    /// another `GetInstancesHealthStatus` request to get the next group of results.
    /// Specify
    /// the value of `NextToken` from the previous response in the next request.
    next_token: ?[]const u8 = null,

    /// A complex type that contains the IDs and the health status of the instances
    /// that you
    /// specified in the `GetInstancesHealthStatus` request.
    status: ?[]const aws.map.MapEntry(HealthStatus) = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstancesHealthStatusInput, options: CallOptions) !GetInstancesHealthStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstancesHealthStatusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.GetInstancesHealthStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstancesHealthStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInstancesHealthStatusOutput, body, allocator);
}
