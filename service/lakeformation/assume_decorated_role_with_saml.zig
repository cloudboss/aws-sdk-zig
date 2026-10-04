const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssumeDecoratedRoleWithSAMLInput = struct {
    /// The time period, between 900 and 43,200 seconds, for the timeout of the
    /// temporary credentials.
    duration_seconds: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the SAML provider in IAM that describes
    /// the IdP.
    principal_arn: []const u8,

    /// The role that represents an IAM principal whose scope down policy allows it
    /// to call credential vending APIs such as `GetTemporaryTableCredentials`. The
    /// caller must also have iam:PassRole permission on this role.
    role_arn: []const u8,

    /// A SAML assertion consisting of an assertion statement for the user who needs
    /// temporary credentials. This must match the SAML assertion that was issued to
    /// IAM. This must be Base64 encoded.
    saml_assertion: []const u8,

    pub const json_field_names = .{
        .duration_seconds = "DurationSeconds",
        .principal_arn = "PrincipalArn",
        .role_arn = "RoleArn",
        .saml_assertion = "SAMLAssertion",
    };
};

pub const AssumeDecoratedRoleWithSAMLOutput = struct {
    /// The access key ID for the temporary credentials. (The access key consists of
    /// an access key ID and a secret key).
    access_key_id: ?[]const u8 = null,

    /// The date and time when the temporary credentials expire.
    expiration: ?i64 = null,

    /// The secret key for the temporary credentials. (The access key consists of an
    /// access key ID and a secret key).
    secret_access_key: ?[]const u8 = null,

    /// The session token for the temporary credentials.
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .expiration = "Expiration",
        .secret_access_key = "SecretAccessKey",
        .session_token = "SessionToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssumeDecoratedRoleWithSAMLInput, options: CallOptions) !AssumeDecoratedRoleWithSAMLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssumeDecoratedRoleWithSAMLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/AssumeDecoratedRoleWithSAML";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PrincipalArn\":");
    try aws.json.writeValue(@TypeOf(input.principal_arn), input.principal_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SAMLAssertion\":");
    try aws.json.writeValue(@TypeOf(input.saml_assertion), input.saml_assertion, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssumeDecoratedRoleWithSAMLOutput {
    const result: AssumeDecoratedRoleWithSAMLOutput = try aws.json.parseJsonObject(
        AssumeDecoratedRoleWithSAMLOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
