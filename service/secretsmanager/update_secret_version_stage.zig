const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateSecretVersionStageInput = struct {
    /// The ID of the version to add the staging label to. To remove a label from a
    /// version,
    /// then do not specify this parameter.
    ///
    /// If the staging label is already attached to a different version of the
    /// secret, then
    /// you must also specify the `RemoveFromVersionId` parameter.
    move_to_version_id: ?[]const u8 = null,

    /// The ID of the version that the staging label is to be removed from. If the
    /// staging
    /// label you are trying to attach to one version is already attached to a
    /// different
    /// version, then you must include this parameter and specify the version that
    /// the label is
    /// to be removed from. If the label is attached and you either do not specify
    /// this
    /// parameter, or the version ID does not match, then the operation fails.
    remove_from_version_id: ?[]const u8 = null,

    /// The ARN or the name of the secret with the version and staging labelsto
    /// modify.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    /// The staging label to add to this version.
    version_stage: []const u8,

    pub const json_field_names = .{
        .move_to_version_id = "MoveToVersionId",
        .remove_from_version_id = "RemoveFromVersionId",
        .secret_id = "SecretId",
        .version_stage = "VersionStage",
    };
};

pub const UpdateSecretVersionStageOutput = struct {
    /// The ARN of the secret that was updated.
    arn: ?[]const u8 = null,

    /// The name of the secret that was updated.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecretVersionStageInput, options: CallOptions) !UpdateSecretVersionStageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecretVersionStageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "secretsmanager.UpdateSecretVersionStage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecretVersionStageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSecretVersionStageOutput, body, allocator);
}
