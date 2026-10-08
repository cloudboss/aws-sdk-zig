const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionAuthorizationType = @import("connection_authorization_type.zig").ConnectionAuthorizationType;
const CreateConnectionAuthRequestParameters = @import("create_connection_auth_request_parameters.zig").CreateConnectionAuthRequestParameters;
const ConnectivityResourceParameters = @import("connectivity_resource_parameters.zig").ConnectivityResourceParameters;
const ConnectionState = @import("connection_state.zig").ConnectionState;

pub const CreateConnectionInput = struct {
    /// The type of authorization to use for the connection.
    ///
    /// OAUTH tokens are refreshed when a 401 or 407 response is returned.
    authorization_type: ConnectionAuthorizationType,

    /// The
    /// authorization parameters to use to authorize with the endpoint.
    ///
    /// You must include only authorization parameters for the `AuthorizationType`
    /// you specify.
    auth_parameters: CreateConnectionAuthRequestParameters,

    /// A description for the connection to create.
    description: ?[]const u8 = null,

    /// For connections to private APIs, the parameters to use for invoking the API.
    ///
    /// For more information, see [Connecting to private
    /// APIs](https://docs.aws.amazon.com/eventbridge/latest/userguide/connection-private.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    invocation_connectivity_parameters: ?ConnectivityResourceParameters = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use, if you choose to use a customer
    /// managed key to encrypt this connection. The identifier can be the key
    /// Amazon Resource Name (ARN), KeyId, key alias, or key alias ARN.
    ///
    /// If you do not specify a customer managed key identifier, EventBridge uses an
    /// Amazon Web Services owned key to encrypt the connection.
    ///
    /// For more information, see [Identify and view
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/viewing-keys.html) in the *Key Management Service
    /// Developer Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// The name for the connection to create.
    name: []const u8,

    pub const json_field_names = .{
        .authorization_type = "AuthorizationType",
        .auth_parameters = "AuthParameters",
        .description = "Description",
        .invocation_connectivity_parameters = "InvocationConnectivityParameters",
        .kms_key_identifier = "KmsKeyIdentifier",
        .name = "Name",
    };
};

pub const CreateConnectionOutput = struct {
    /// The ARN of the connection that was created by the request.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection that was created by the request.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// A time stamp for the time that the connection was last updated.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.CreateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
}
