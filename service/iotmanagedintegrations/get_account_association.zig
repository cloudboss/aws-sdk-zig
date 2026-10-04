const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationState = @import("association_state.zig").AssociationState;
const GeneralAuthorizationName = @import("general_authorization_name.zig").GeneralAuthorizationName;

pub const GetAccountAssociationInput = struct {
    /// The unique identifier of the account association to retrieve.
    account_association_id: []const u8,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
    };
};

pub const GetAccountAssociationOutput = struct {
    /// The unique identifier of the retrieved account association.
    account_association_id: []const u8,

    /// The Amazon Resource Name (ARN) of the account association.
    arn: ?[]const u8 = null,

    /// The current status state for the account association.
    association_state: AssociationState,

    /// The identifier of the connector destination associated with this account
    /// association.
    connector_destination_id: ?[]const u8 = null,

    /// The description of the account association.
    description: ?[]const u8 = null,

    /// The error message explaining the current account association error.
    error_message: ?[]const u8 = null,

    /// The General Authorization reference by authorization material name.
    general_authorization: ?GeneralAuthorizationName = null,

    /// The name of the account association.
    name: ?[]const u8 = null,

    /// Third party IoT platform OAuth authorization server URL backed with all the
    /// required parameters to perform end-user authentication. This field will be
    /// empty when using General Authorization flows that do not require OAuth.
    o_auth_authorization_url: ?[]const u8 = null,

    /// A set of key/value pairs that are used to manage the account association.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .arn = "Arn",
        .association_state = "AssociationState",
        .connector_destination_id = "ConnectorDestinationId",
        .description = "Description",
        .error_message = "ErrorMessage",
        .general_authorization = "GeneralAuthorization",
        .name = "Name",
        .o_auth_authorization_url = "OAuthAuthorizationUrl",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountAssociationInput, options: CallOptions) !GetAccountAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/account-associations/");
    try path_buf.appendSlice(allocator, input.account_association_id);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountAssociationOutput {
    var result: GetAccountAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAccountAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
