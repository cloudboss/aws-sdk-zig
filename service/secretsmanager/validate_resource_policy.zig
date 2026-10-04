const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ValidationErrorsEntry = @import("validation_errors_entry.zig").ValidationErrorsEntry;

pub const ValidateResourcePolicyInput = struct {
    /// A JSON-formatted string that contains an Amazon Web Services resource-based
    /// policy. The policy in
    /// the string identifies who can access or manage this secret and its versions.
    /// For example
    /// policies, see [Permissions
    /// policy
    /// examples](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html).
    resource_policy: []const u8,

    /// The ARN or name of the secret with the resource-based policy you want to
    /// validate.
    secret_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_policy = "ResourcePolicy",
        .secret_id = "SecretId",
    };
};

pub const ValidateResourcePolicyOutput = struct {
    /// True if your policy passes validation, otherwise false.
    policy_validation_passed: ?bool = null,

    /// Validation errors if your policy didn't pass validation.
    validation_errors: ?[]const ValidationErrorsEntry = null,

    pub const json_field_names = .{
        .policy_validation_passed = "PolicyValidationPassed",
        .validation_errors = "ValidationErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateResourcePolicyInput, options: CallOptions) !ValidateResourcePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateResourcePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.ValidateResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ValidateResourcePolicyOutput, body, allocator);
}
