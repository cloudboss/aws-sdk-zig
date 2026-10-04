const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceConfigurationFilter = @import("instance_configuration_filter.zig").InstanceConfigurationFilter;
const InstanceTypeInfo = @import("instance_type_info.zig").InstanceTypeInfo;

pub const ListInstanceTypesInput = struct {
    /// Optional filter to narrow instance type results based on configuration
    /// requirements. Only returns instance types that support the specified
    /// combination of tenancy, platform type, and billing mode.
    instance_configuration_filter: ?InstanceConfigurationFilter = null,

    /// Maximum number of instance types to return in a single API call. Enables
    /// pagination of instance type results.
    max_results: ?i32 = null,

    /// Pagination token for retrieving subsequent pages of instance type results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_configuration_filter = "InstanceConfigurationFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListInstanceTypesOutput = struct {
    /// Collection of supported instance types for WorkSpaces Instances.
    instance_types: ?[]const InstanceTypeInfo = null,

    /// Token for retrieving additional instance types if the result set is
    /// paginated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_types = "InstanceTypes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInstanceTypesInput, options: CallOptions) !ListInstanceTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-instances", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInstanceTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-instances", "Workspaces Instances", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "EUCMIFrontendAPIService.ListInstanceTypes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInstanceTypesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListInstanceTypesOutput, body, allocator);
}
