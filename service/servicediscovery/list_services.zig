const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceFilter = @import("service_filter.zig").ServiceFilter;
const ServiceSummary = @import("service_summary.zig").ServiceSummary;

pub const ListServicesInput = struct {
    /// A complex type that contains specifications for the namespaces that you want
    /// to list
    /// services for.
    ///
    /// If you specify more than one filter, an operation must match all filters to
    /// be returned by
    /// `ListServices`.
    filters: ?[]const ServiceFilter = null,

    /// The maximum number of services that you want Cloud Map to return in the
    /// response to a
    /// `ListServices` request. If you don't specify a value for `MaxResults`,
    /// Cloud Map returns up to 100 services.
    max_results: ?i32 = null,

    /// For the first `ListServices` request, omit this value.
    ///
    /// If the response contains `NextToken`, submit another `ListServices`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` services and then filters them based on the
    /// specified criteria. It's possible that no services in the first `MaxResults`
    /// services
    /// matched the specified criteria but that subsequent groups of `MaxResults`
    /// services do
    /// contain services that match the criteria.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListServicesOutput = struct {
    /// If the response contains `NextToken`, submit another `ListServices`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` services and then filters them based on the
    /// specified criteria. It's possible that no services in the first `MaxResults`
    /// services
    /// matched the specified criteria but that subsequent groups of `MaxResults`
    /// services do
    /// contain services that match the criteria.
    next_token: ?[]const u8 = null,

    /// An array that contains one `ServiceSummary` object for each service that
    /// matches
    /// the specified filter criteria.
    services: ?[]const ServiceSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .services = "Services",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServicesInput, options: CallOptions) !ListServicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServicesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.ListServices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServicesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServicesOutput, body, allocator);
}
