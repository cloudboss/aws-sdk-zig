const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FederationStatus = @import("federation_status.zig").FederationStatus;

pub const EnableFederationInput = struct {
    /// The ARN (or ID suffix of the ARN) of the event data store for which you want
    /// to enable Lake query federation.
    event_data_store: []const u8,

    /// The ARN of the federation role to use for the event data store. Amazon Web
    /// Services services like Lake Formation use this federation role to access
    /// data for the federated event
    /// data store. The federation role must exist in your account and provide the
    /// [required minimum
    /// permissions](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-federation.html#query-federation-permissions-role).
    federation_role_arn: []const u8,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
        .federation_role_arn = "FederationRoleArn",
    };
};

pub const EnableFederationOutput = struct {
    /// The ARN of the event data store for which you enabled Lake query federation.
    event_data_store_arn: ?[]const u8 = null,

    /// The ARN of the federation role.
    federation_role_arn: ?[]const u8 = null,

    /// The federation status.
    federation_status: ?FederationStatus = null,

    pub const json_field_names = .{
        .event_data_store_arn = "EventDataStoreArn",
        .federation_role_arn = "FederationRoleArn",
        .federation_status = "FederationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableFederationInput, options: CallOptions) !EnableFederationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableFederationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.EnableFederation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableFederationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(EnableFederationOutput, body, allocator);
}
