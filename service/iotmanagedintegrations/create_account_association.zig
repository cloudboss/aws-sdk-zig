const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeneralAuthorizationName = @import("general_authorization_name.zig").GeneralAuthorizationName;
const AssociationState = @import("association_state.zig").AssociationState;

pub const CreateAccountAssociationInput = struct {
    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The identifier of the connector destination.
    connector_destination_id: []const u8,

    /// A description of the account association request.
    description: ?[]const u8 = null,

    /// The General Authorization reference by authorization material name.
    general_authorization: ?GeneralAuthorizationName = null,

    /// The name of the destination for the new account association.
    name: ?[]const u8 = null,

    /// A set of key/value pairs that are used to manage the account association.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .connector_destination_id = "ConnectorDestinationId",
        .description = "Description",
        .general_authorization = "GeneralAuthorization",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateAccountAssociationOutput = struct {
    /// The identifier for the account association request.
    account_association_id: []const u8,

    /// The Amazon Resource Name (ARN) of the account association.
    arn: ?[]const u8 = null,

    /// The current state of the account association request.
    association_state: AssociationState,

    /// Third-party IoT platform OAuth authorization server URL backed with all the
    /// required parameters to perform end-user authentication. This field will be
    /// empty when using General Authorization flows that do not require OAuth.
    o_auth_authorization_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_association_id = "AccountAssociationId",
        .arn = "Arn",
        .association_state = "AssociationState",
        .o_auth_authorization_url = "OAuthAuthorizationUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccountAssociationInput, options: CallOptions) !CreateAccountAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccountAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/account-associations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectorDestinationId\":");
    try aws.json.writeValue(@TypeOf(input.connector_destination_id), input.connector_destination_id, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.general_authorization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GeneralAuthorization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccountAssociationOutput {
    var result: CreateAccountAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAccountAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
