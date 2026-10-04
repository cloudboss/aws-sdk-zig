const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateApplicationRequest = @import("create_application_request.zig").CreateApplicationRequest;
const ApplicationResponse = @import("application_response.zig").ApplicationResponse;

pub const CreateAppInput = struct {
    create_application_request: CreateApplicationRequest,

    pub const json_field_names = .{
        .create_application_request = "CreateApplicationRequest",
    };
};

pub const CreateAppOutput = struct {
    application_response: ?ApplicationResponse = null,

    pub const json_field_names = .{
        .application_response = "ApplicationResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAppInput, options: CallOptions) !CreateAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/apps";

    const body = try aws.json.jsonStringify(input.create_application_request, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAppOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateAppOutput = .{};

    return result;
}
