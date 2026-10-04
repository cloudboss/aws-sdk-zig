const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListServiceInstancesFilter = @import("list_service_instances_filter.zig").ListServiceInstancesFilter;
const ListServiceInstancesSortBy = @import("list_service_instances_sort_by.zig").ListServiceInstancesSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ServiceInstanceSummary = @import("service_instance_summary.zig").ServiceInstanceSummary;

pub const ListServiceInstancesInput = struct {
    /// An array of filtering criteria that scope down the result list. By default,
    /// all service
    /// instances in the Amazon Web Services account are returned.
    filters: ?[]const ListServiceInstancesFilter = null,

    /// The maximum number of service instances to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next service in the array of
    /// service instances,
    /// after the list of service instances that was previously requested.
    next_token: ?[]const u8 = null,

    /// The name of the service that the service instance belongs to.
    service_name: ?[]const u8 = null,

    /// The field that the result list is sorted by.
    ///
    /// When you choose to sort by `serviceName`, service instances within each
    /// service
    /// are sorted by service instance name.
    ///
    /// Default: `serviceName`
    sort_by: ?ListServiceInstancesSortBy = null,

    /// Result list sort order.
    ///
    /// Default: `ASCENDING`
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_name = "serviceName",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListServiceInstancesOutput = struct {
    /// A token that indicates the location of the next service instance in the
    /// array of service
    /// instances, after the current requested list of service instances.
    next_token: ?[]const u8 = null,

    /// An array of service instances with summary data.
    service_instances: ?[]const ServiceInstanceSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_instances = "serviceInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceInstancesInput, options: CallOptions) !ListServiceInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceInstancesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListServiceInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceInstancesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListServiceInstancesOutput, body, allocator);
}
