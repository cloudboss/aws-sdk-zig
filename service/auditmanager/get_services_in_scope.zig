const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceMetadata = @import("service_metadata.zig").ServiceMetadata;

pub const GetServicesInScopeInput = struct {
};

pub const GetServicesInScopeOutput = struct {
    /// The metadata that's associated with the Amazon Web Services service.
    service_metadata: ?[]const ServiceMetadata = null,

    pub const json_field_names = .{
        .service_metadata = "serviceMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServicesInScopeInput, options: CallOptions) !GetServicesInScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServicesInScopeInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/services";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServicesInScopeOutput {
    var result: GetServicesInScopeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServicesInScopeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
