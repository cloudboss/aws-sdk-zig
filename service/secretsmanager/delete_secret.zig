const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteSecretInput = struct {
    /// Specifies whether to delete the secret without any recovery window. You
    /// can't use both
    /// this parameter and `RecoveryWindowInDays` in the same call. If you don't use
    /// either, then by default Secrets Manager uses a 30 day recovery window.
    ///
    /// Secrets Manager performs the actual deletion with an asynchronous background
    /// process, so there
    /// might be a short delay before the secret is permanently deleted. If you
    /// delete a secret
    /// and then immediately create a secret with the same name, use appropriate
    /// back off and
    /// retry logic.
    ///
    /// If you forcibly delete an already deleted or nonexistent secret, the
    /// operation does
    /// not return `ResourceNotFoundException`.
    ///
    /// Use this parameter with caution. This parameter causes the operation to skip
    /// the
    /// normal recovery window before the permanent deletion that Secrets Manager
    /// would normally
    /// impose with the `RecoveryWindowInDays` parameter. If you delete a secret
    /// with the `ForceDeleteWithoutRecovery` parameter, then you have no
    /// opportunity to recover the secret. You lose the secret permanently.
    force_delete_without_recovery: ?bool = null,

    /// The number of days from 7 to 30 that Secrets Manager waits before
    /// permanently deleting the
    /// secret. You can't use both this parameter and `ForceDeleteWithoutRecovery`
    /// in
    /// the same call. If you don't use either, then by default Secrets Manager uses
    /// a 30 day recovery
    /// window.
    recovery_window_in_days: ?i64 = null,

    /// The ARN or name of the secret to delete.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    pub const json_field_names = .{
        .force_delete_without_recovery = "ForceDeleteWithoutRecovery",
        .recovery_window_in_days = "RecoveryWindowInDays",
        .secret_id = "SecretId",
    };
};

pub const DeleteSecretOutput = struct {
    /// The ARN of the secret.
    arn: ?[]const u8 = null,

    /// The date and time after which this secret Secrets Manager can permanently
    /// delete this secret,
    /// and it can no longer be restored. This value is the date and time of the
    /// delete request
    /// plus the number of days in `RecoveryWindowInDays`.
    deletion_date: ?i64 = null,

    /// The name of the secret.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .deletion_date = "DeletionDate",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteSecretInput, options: CallOptions) !DeleteSecretOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteSecretInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.DeleteSecret");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteSecretOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteSecretOutput, body, allocator);
}
