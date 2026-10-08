const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteContainerImageInput = struct {
    /// The name of the container image to delete from the container service.
    ///
    /// Use the `GetContainerImages` action to get the name of the container images
    /// that are registered to a container service.
    ///
    /// Container images sourced from your Lightsail container service, that are
    /// registered
    /// and stored on your service, start with a colon (`:`). For example,
    /// `:container-service-1.mystaticwebsite.1`. Container images sourced from a
    /// public registry like Docker Hub don't start with a colon. For example,
    /// `nginx:latest` or `nginx`.
    image: []const u8,

    /// The name of the container service for which to delete a registered container
    /// image.
    service_name: []const u8,

    pub const json_field_names = .{
        .image = "image",
        .service_name = "serviceName",
    };
};

pub const DeleteContainerImageOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteContainerImageInput, options: CallOptions) !DeleteContainerImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteContainerImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.DeleteContainerImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteContainerImageOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
