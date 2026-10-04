const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ServiceInstance = @import("service_instance.zig").ServiceInstance;

pub const CreateServiceInstanceInput = struct {
    /// The client token of the service instance to create.
    client_token: ?[]const u8 = null,

    /// The name of the service instance to create.
    name: []const u8,

    /// The name of the service the service instance is added to.
    service_name: []const u8,

    /// The spec for the service instance you want to create.
    spec: []const u8,

    /// An optional list of metadata items that you can associate with the Proton
    /// service instance.
    /// A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    /// To create a new major and minor version of the service template,
    /// *exclude*
    /// `major Version`.
    template_major_version: ?[]const u8 = null,

    /// To create a new minor version of the service template, include a `major
    /// Version`.
    template_minor_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .name = "name",
        .service_name = "serviceName",
        .spec = "spec",
        .tags = "tags",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
    };
};

pub const CreateServiceInstanceOutput = struct {
    /// The detailed data of the service instance being created.
    service_instance: ?ServiceInstance = null,

    pub const json_field_names = .{
        .service_instance = "serviceInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceInstanceInput, options: CallOptions) !CreateServiceInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateServiceInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceInstanceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateServiceInstanceOutput, body, allocator);
}
