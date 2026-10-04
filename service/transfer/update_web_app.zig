const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateWebAppEndpointDetails = @import("update_web_app_endpoint_details.zig").UpdateWebAppEndpointDetails;
const UpdateWebAppIdentityProviderDetails = @import("update_web_app_identity_provider_details.zig").UpdateWebAppIdentityProviderDetails;
const WebAppUnits = @import("web_app_units.zig").WebAppUnits;

pub const UpdateWebAppInput = struct {
    /// The `AccessEndpoint` is the URL that you provide to your users for them to
    /// interact with the Transfer Family web app. You can specify a custom URL or
    /// use the default value.
    access_endpoint: ?[]const u8 = null,

    /// The updated endpoint configuration for the web app. You can modify the
    /// endpoint type and VPC configuration settings.
    endpoint_details: ?UpdateWebAppEndpointDetails = null,

    /// Provide updated identity provider values in a
    /// `WebAppIdentityProviderDetails` object.
    identity_provider_details: ?UpdateWebAppIdentityProviderDetails = null,

    /// Provide the identifier of the web app that you are updating.
    web_app_id: []const u8,

    /// A union that contains the value for number of concurrent connections or the
    /// user sessions on your web app.
    web_app_units: ?WebAppUnits = null,

    pub const json_field_names = .{
        .access_endpoint = "AccessEndpoint",
        .endpoint_details = "EndpointDetails",
        .identity_provider_details = "IdentityProviderDetails",
        .web_app_id = "WebAppId",
        .web_app_units = "WebAppUnits",
    };
};

pub const UpdateWebAppOutput = struct {
    /// Returns the unique identifier for the web app being updated.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .web_app_id = "WebAppId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebAppInput, options: CallOptions) !UpdateWebAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.UpdateWebApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWebAppOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateWebAppOutput, body, allocator);
}
