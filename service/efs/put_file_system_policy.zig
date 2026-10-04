const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutFileSystemPolicyInput = struct {
    /// (Optional) A boolean that specifies whether or not to bypass the
    /// `FileSystemPolicy` lockout safety check. The lockout safety check
    /// determines whether the policy in the request will lock out, or prevent, the
    /// IAM principal that is making the request from making future
    /// `PutFileSystemPolicy` requests on this file system.
    /// Set `BypassPolicyLockoutSafetyCheck` to `True` only when you intend to
    /// prevent
    /// the IAM principal that is making the request from making subsequent
    /// `PutFileSystemPolicy` requests on this file system.
    /// The default value is `False`.
    bypass_policy_lockout_safety_check: ?bool = null,

    /// The ID of the EFS file system that you want to create or update the
    /// `FileSystemPolicy` for.
    file_system_id: []const u8,

    /// The `FileSystemPolicy` that you're creating. Accepts a JSON formatted
    /// policy definition. EFS file system policies have a 20,000 character limit.
    /// To find
    /// out more about the elements that make up a file system policy, see
    /// [Resource-based policies within Amazon
    /// EFS](https://docs.aws.amazon.com/efs/latest/ug/security_iam_service-with-iam.html#security_iam_service-with-iam-resource-based-policies).
    policy: []const u8,

    pub const json_field_names = .{
        .bypass_policy_lockout_safety_check = "BypassPolicyLockoutSafetyCheck",
        .file_system_id = "FileSystemId",
        .policy = "Policy",
    };
};

pub const PutFileSystemPolicyOutput = struct {
    /// Specifies the EFS file system to which the `FileSystemPolicy`
    /// applies.
    file_system_id: ?[]const u8 = null,

    /// The JSON formatted `FileSystemPolicy` for the EFS file
    /// system.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutFileSystemPolicyInput, options: CallOptions) !PutFileSystemPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutFileSystemPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bypass_policy_lockout_safety_check) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BypassPolicyLockoutSafetyCheck\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutFileSystemPolicyOutput {
    const result: PutFileSystemPolicyOutput = try aws.json.parseJsonObject(
        PutFileSystemPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
