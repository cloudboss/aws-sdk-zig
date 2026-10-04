const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const VpcConnectionProperties = @import("vpc_connection_properties.zig").VpcConnectionProperties;
const OAuthClientAuthenticationType = @import("o_auth_client_authentication_type.zig").OAuthClientAuthenticationType;
const Tag = @import("tag.zig").Tag;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateOAuthClientApplicationInput = struct {
    /// The Amazon Web Services account ID.
    aws_account_id: []const u8,

    /// The client ID of the OAuth application that is registered with the identity
    /// provider.
    client_id: []const u8,

    /// The client secret of the OAuth application that is registered with the
    /// identity provider.
    client_secret: []const u8,

    /// The type of data source that the OAuthClientApplication is used with. Valid
    /// values are `SNOWFLAKE`.
    data_source_type: ?DataSourceType = null,

    identity_provider_vpc_connection_properties: ?VpcConnectionProperties = null,

    /// The display name for the OAuthClientApplication.
    name: []const u8,

    /// The authorization endpoint URL of the identity provider that is used to
    /// obtain authorization codes.
    o_auth_authorization_endpoint_url: ?[]const u8 = null,

    /// An ID for the OAuthClientApplication that you want to create. This ID is
    /// unique per Amazon Web Services Region for each Amazon Web Services account.
    o_auth_client_application_id: []const u8,

    /// The authentication type to use for the OAuthClientApplication. This
    /// determines the OAuth 2.0 grant flow that is used when the data source
    /// connects to the identity provider. Valid values are `TOKEN`.
    o_auth_client_authentication_type: OAuthClientAuthenticationType,

    /// The OAuth scopes that are requested when the OAuthClientApplication obtains
    /// an access token from the identity provider.
    o_auth_scopes: ?[]const u8 = null,

    /// The token endpoint URL of the identity provider that is used to obtain
    /// access tokens.
    o_auth_token_endpoint_url: []const u8,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the OAuthClientApplication.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .data_source_type = "DataSourceType",
        .identity_provider_vpc_connection_properties = "IdentityProviderVpcConnectionProperties",
        .name = "Name",
        .o_auth_authorization_endpoint_url = "OAuthAuthorizationEndpointUrl",
        .o_auth_client_application_id = "OAuthClientApplicationId",
        .o_auth_client_authentication_type = "OAuthClientAuthenticationType",
        .o_auth_scopes = "OAuthScopes",
        .o_auth_token_endpoint_url = "OAuthTokenEndpointUrl",
        .tags = "Tags",
    };
};

pub const CreateOAuthClientApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the OAuthClientApplication.
    arn: ?[]const u8 = null,

    /// The status of creating the OAuthClientApplication.
    creation_status: ?ResourceStatus = null,

    /// The ID of the OAuthClientApplication. This ID is unique per Amazon Web
    /// Services Region for each Amazon Web Services account.
    o_auth_client_application_id: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_status = "CreationStatus",
        .o_auth_client_application_id = "OAuthClientApplicationId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOAuthClientApplicationInput, options: CallOptions) !CreateOAuthClientApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOAuthClientApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/oauth-client-applications");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientId\":");
    try aws.json.writeValue(@TypeOf(input.client_id), input.client_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientSecret\":");
    try aws.json.writeValue(@TypeOf(input.client_secret), input.client_secret, allocator, &body_buf);
    has_prev = true;
    if (input.data_source_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSourceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_provider_vpc_connection_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdentityProviderVpcConnectionProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.o_auth_authorization_endpoint_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OAuthAuthorizationEndpointUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OAuthClientApplicationId\":");
    try aws.json.writeValue(@TypeOf(input.o_auth_client_application_id), input.o_auth_client_application_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OAuthClientAuthenticationType\":");
    try aws.json.writeValue(@TypeOf(input.o_auth_client_authentication_type), input.o_auth_client_authentication_type, allocator, &body_buf);
    has_prev = true;
    if (input.o_auth_scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OAuthScopes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OAuthTokenEndpointUrl\":");
    try aws.json.writeValue(@TypeOf(input.o_auth_token_endpoint_url), input.o_auth_token_endpoint_url, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOAuthClientApplicationOutput {
    var result: CreateOAuthClientApplicationOutput = try aws.json.parseJsonObject(
        CreateOAuthClientApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
