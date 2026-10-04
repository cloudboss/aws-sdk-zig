const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WebAppEndpointDetails = @import("web_app_endpoint_details.zig").WebAppEndpointDetails;
const WebAppIdentityProviderDetails = @import("web_app_identity_provider_details.zig").WebAppIdentityProviderDetails;
const Tag = @import("tag.zig").Tag;
const WebAppEndpointPolicy = @import("web_app_endpoint_policy.zig").WebAppEndpointPolicy;
const WebAppUnits = @import("web_app_units.zig").WebAppUnits;

pub const CreateWebAppInput = struct {
    /// The `AccessEndpoint` is the URL that you provide to your users for them to
    /// interact with the Transfer Family web app. You can specify a custom URL or
    /// use the default value.
    ///
    /// Before you enter a custom URL for this parameter, follow the steps described
    /// in [Update your access endpoint with a custom
    /// URL](https://docs.aws.amazon.com/transfer/latest/userguide/webapp-customize.html).
    access_endpoint: ?[]const u8 = null,

    /// The endpoint configuration for the web app. You can specify whether the web
    /// app endpoint is publicly accessible or hosted within a VPC.
    endpoint_details: ?WebAppEndpointDetails = null,

    /// You can provide a structure that contains the details for the identity
    /// provider to use with your web app.
    ///
    /// For more details about this parameter, see [Configure your identity provider
    /// for Transfer Family web
    /// apps](https://docs.aws.amazon.com/transfer/latest/userguide/webapp-identity-center.html).
    identity_provider_details: WebAppIdentityProviderDetails,

    /// Key-value pairs that can be used to group and search for web apps.
    tags: ?[]const Tag = null,

    /// Setting for the type of endpoint policy for the web app. The default value
    /// is `STANDARD`.
    ///
    /// If you are creating the web app in an Amazon Web Services GovCloud (US)
    /// Region, you can set this parameter to `FIPS`.
    web_app_endpoint_policy: ?WebAppEndpointPolicy = null,

    /// A union that contains the value for number of concurrent connections or the
    /// user sessions on your web app.
    web_app_units: ?WebAppUnits = null,

    pub const json_field_names = .{
        .access_endpoint = "AccessEndpoint",
        .endpoint_details = "EndpointDetails",
        .identity_provider_details = "IdentityProviderDetails",
        .tags = "Tags",
        .web_app_endpoint_policy = "WebAppEndpointPolicy",
        .web_app_units = "WebAppUnits",
    };
};

pub const CreateWebAppOutput = struct {
    /// Returns a unique identifier for the web app.
    web_app_id: []const u8,

    pub const json_field_names = .{
        .web_app_id = "WebAppId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWebAppInput, options: CallOptions) !CreateWebAppOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWebAppInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.CreateWebApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWebAppOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWebAppOutput, body, allocator);
}
