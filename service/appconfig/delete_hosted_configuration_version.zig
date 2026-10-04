const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteHostedConfigurationVersionInput = struct {
    /// The application ID.
    application_id: []const u8,

    /// The configuration profile ID.
    configuration_profile_id: []const u8,

    /// The versions number to delete.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_profile_id = "ConfigurationProfileId",
        .version_number = "VersionNumber",
    };
};

pub const DeleteHostedConfigurationVersionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteHostedConfigurationVersionInput, options: CallOptions) !DeleteHostedConfigurationVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteHostedConfigurationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/configurationprofiles/");
    try path_buf.appendSlice(allocator, input.configuration_profile_id);
    try path_buf.appendSlice(allocator, "/hostedconfigurationversions/");
    try path_buf.appendSlice(allocator, input.version_number);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteHostedConfigurationVersionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteHostedConfigurationVersionOutput = .{};

    return result;
}
