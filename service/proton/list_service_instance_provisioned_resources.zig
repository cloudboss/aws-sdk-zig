const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisionedResource = @import("provisioned_resource.zig").ProvisionedResource;

pub const ListServiceInstanceProvisionedResourcesInput = struct {
    /// A token that indicates the location of the next provisioned resource in the
    /// array of
    /// provisioned resources, after the list of provisioned resources that was
    /// previously
    /// requested.
    next_token: ?[]const u8 = null,

    /// The name of the service instance whose provisioned resources you want.
    service_instance_name: []const u8,

    /// The name of the service that `serviceInstanceName` is associated to.
    service_name: []const u8,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
    };
};

pub const ListServiceInstanceProvisionedResourcesOutput = struct {
    /// A token that indicates the location of the next provisioned resource in the
    /// array of
    /// provisioned resources, after the current requested list of provisioned
    /// resources.
    next_token: ?[]const u8 = null,

    /// An array of provisioned resources for a service instance.
    provisioned_resources: ?[]const ProvisionedResource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .provisioned_resources = "provisionedResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceInstanceProvisionedResourcesInput, options: CallOptions) !ListServiceInstanceProvisionedResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceInstanceProvisionedResourcesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListServiceInstanceProvisionedResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceInstanceProvisionedResourcesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListServiceInstanceProvisionedResourcesOutput, body, allocator);
}
