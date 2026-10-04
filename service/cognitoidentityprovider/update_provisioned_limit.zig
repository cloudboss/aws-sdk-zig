const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LimitDefinitionType = @import("limit_definition_type.zig").LimitDefinitionType;
const LimitType = @import("limit_type.zig").LimitType;

pub const UpdateProvisionedLimitInput = struct {
    /// The limit to update. Specify the limit class and the attributes that
    /// identify the
    /// limit.
    limit_definition: LimitDefinitionType,

    /// The provisioned rate to set, in requests per second (RPS).
    requested_limit_value: ?i32 = null,

    pub const json_field_names = .{
        .limit_definition = "LimitDefinition",
        .requested_limit_value = "RequestedLimitValue",
    };
};

pub const UpdateProvisionedLimitOutput = struct {
    /// The updated provisioned and default limit values.
    limit: ?LimitType = null,

    pub const json_field_names = .{
        .limit = "Limit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProvisionedLimitInput, options: CallOptions) !UpdateProvisionedLimitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProvisionedLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.UpdateProvisionedLimit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProvisionedLimitOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateProvisionedLimitOutput, body, allocator);
}
