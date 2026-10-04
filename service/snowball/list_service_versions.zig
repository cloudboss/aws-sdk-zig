const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DependentService = @import("dependent_service.zig").DependentService;
const ServiceName = @import("service_name.zig").ServiceName;
const ServiceVersion = @import("service_version.zig").ServiceVersion;

pub const ListServiceVersionsInput = struct {
    /// A list of names and versions of dependant services of the requested service.
    dependent_services: ?[]const DependentService = null,

    /// The maximum number of `ListServiceVersions` objects to return.
    max_results: ?i32 = null,

    /// Because HTTP requests are stateless, this is the starting point for the next
    /// list of returned
    /// `ListServiceVersionsRequest` versions.
    next_token: ?[]const u8 = null,

    /// The name of the service for which you're requesting supported versions.
    service_name: ServiceName,

    pub const json_field_names = .{
        .dependent_services = "DependentServices",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_name = "ServiceName",
    };
};

pub const ListServiceVersionsOutput = struct {
    /// A list of names and versions of dependant services of the service for which
    /// the system provided supported versions.
    dependent_services: ?[]const DependentService = null,

    /// Because HTTP requests are stateless, this is the starting point of the next
    /// list of returned
    /// `ListServiceVersionsResult` results.
    next_token: ?[]const u8 = null,

    /// The name of the service for which the system provided supported versions.
    service_name: ServiceName,

    /// A list of supported versions.
    service_versions: ?[]const ServiceVersion = null,

    pub const json_field_names = .{
        .dependent_services = "DependentServices",
        .next_token = "NextToken",
        .service_name = "ServiceName",
        .service_versions = "ServiceVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceVersionsInput, options: CallOptions) !ListServiceVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snowball", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.ListServiceVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListServiceVersionsOutput, body, allocator);
}
