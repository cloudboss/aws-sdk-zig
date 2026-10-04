const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetResourcePolicyInput = struct {
    /// The ARN or name of the secret to retrieve the attached resource-based policy
    /// for.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    pub const json_field_names = .{
        .secret_id = "SecretId",
    };
};

pub const GetResourcePolicyOutput = struct {
    /// The ARN of the secret that the resource-based policy was retrieved for.
    arn: ?[]const u8 = null,

    /// The name of the secret that the resource-based policy was retrieved for.
    name: ?[]const u8 = null,

    /// A JSON-formatted string that contains the permissions policy attached to the
    /// secret.
    /// For more information about permissions policies, see [Authentication and
    /// access
    /// control for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    resource_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
        .resource_policy = "ResourcePolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcePolicyInput, options: CallOptions) !GetResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "secretsmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("secretsmanager", "Secrets Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.GetResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourcePolicyOutput, body, allocator);
}
