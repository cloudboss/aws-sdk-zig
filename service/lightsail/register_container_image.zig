const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerImage = @import("container_image.zig").ContainerImage;

pub const RegisterContainerImageInput = struct {
    /// The digest of the container image to be registered.
    digest: []const u8,

    /// The label for the container image when it's registered to the container
    /// service.
    ///
    /// Use a descriptive label that you can use to track the different versions of
    /// your
    /// registered container images.
    ///
    /// Use the `GetContainerImages` action to return the container images
    /// registered
    /// to a Lightsail container service. The label is the `` portion
    /// of the following image name example:
    ///
    /// * `:container-service-1..1`
    ///
    /// If the name of your container service is `mycontainerservice`, and the label
    /// that you specify is `mystaticwebsite`, then the name of the registered
    /// container
    /// image will be `:mycontainerservice.mystaticwebsite.1`.
    ///
    /// The number at the end of these image name examples represents the version of
    /// the
    /// registered container image. If you push and register another container image
    /// to the same
    /// Lightsail container service, with the same label, then the version number
    /// for the new
    /// registered container image will be `2`. If you push and register another
    /// container
    /// image, the version number will be `3`, and so on.
    label: []const u8,

    /// The name of the container service for which to register a container image.
    service_name: []const u8,

    pub const json_field_names = .{
        .digest = "digest",
        .label = "label",
        .service_name = "serviceName",
    };
};

pub const RegisterContainerImageOutput = struct {
    /// An object that describes a container image that is registered to a Lightsail
    /// container
    /// service
    container_image: ?ContainerImage = null,

    pub const json_field_names = .{
        .container_image = "containerImage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterContainerImageInput, options: CallOptions) !RegisterContainerImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterContainerImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.RegisterContainerImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterContainerImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterContainerImageOutput, body, allocator);
}
