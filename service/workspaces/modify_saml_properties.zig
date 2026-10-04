const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletableSamlProperty = @import("deletable_saml_property.zig").DeletableSamlProperty;
const SamlProperties = @import("saml_properties.zig").SamlProperties;

pub const ModifySamlPropertiesInput = struct {
    /// The SAML properties to delete as part of your request.
    ///
    /// Specify one of the following options:
    ///
    /// * `SAML_PROPERTIES_USER_ACCESS_URL` to delete the user access URL.
    ///
    /// * `SAML_PROPERTIES_RELAY_STATE_PARAMETER_NAME` to delete the
    /// relay state parameter name.
    properties_to_delete: ?[]const DeletableSamlProperty = null,

    /// The directory identifier for which you want to configure SAML properties.
    resource_id: []const u8,

    /// The properties for configuring SAML 2.0 authentication.
    saml_properties: ?SamlProperties = null,

    pub const json_field_names = .{
        .properties_to_delete = "PropertiesToDelete",
        .resource_id = "ResourceId",
        .saml_properties = "SamlProperties",
    };
};

pub const ModifySamlPropertiesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifySamlPropertiesInput, options: CallOptions) !ModifySamlPropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifySamlPropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.ModifySamlProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifySamlPropertiesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
