const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentUpdateType = @import("deployment_update_type.zig").DeploymentUpdateType;
const ServiceInstance = @import("service_instance.zig").ServiceInstance;

pub const UpdateServiceInstanceInput = struct {
    /// The client token of the service instance to update.
    client_token: ?[]const u8 = null,

    /// The deployment type. It defines the mode for updating a service instance, as
    /// follows:
    ///
    /// `NONE`
    ///
    /// In this mode, a deployment *doesn't* occur. Only the requested
    /// metadata parameters are updated.
    ///
    /// `CURRENT_VERSION`
    ///
    /// In this mode, the service instance is deployed and updated with the new spec
    /// that
    /// you provide. Only requested parameters are updated. *Don’t* include
    /// major or minor version parameters when you use this deployment type.
    ///
    /// `MINOR_VERSION`
    ///
    /// In this mode, the service instance is deployed and updated with the
    /// published,
    /// recommended (latest) minor version of the current major version in use, by
    /// default. You
    /// can also specify a different minor version of the current major version in
    /// use.
    ///
    /// `MAJOR_VERSION`
    ///
    /// In this mode, the service instance is deployed and updated with the
    /// published,
    /// recommended (latest) major and minor version of the current template, by
    /// default. You
    /// can specify a different major version that's higher than the major version
    /// in use and a
    /// minor version.
    deployment_type: DeploymentUpdateType,

    /// The name of the service instance to update.
    name: []const u8,

    /// The name of the service that the service instance belongs to.
    service_name: []const u8,

    /// The formatted specification that defines the service instance update.
    spec: ?[]const u8 = null,

    /// The major version of the service template to update.
    template_major_version: ?[]const u8 = null,

    /// The minor version of the service template to update.
    template_minor_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .deployment_type = "deploymentType",
        .name = "name",
        .service_name = "serviceName",
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
    };
};

pub const UpdateServiceInstanceOutput = struct {
    /// The service instance summary data that's returned by Proton.
    service_instance: ?ServiceInstance = null,

    pub const json_field_names = .{
        .service_instance = "serviceInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceInstanceInput, options: CallOptions) !UpdateServiceInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateServiceInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceInstanceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateServiceInstanceOutput, body, allocator);
}
