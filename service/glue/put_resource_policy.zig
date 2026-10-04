const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnableHybridValues = @import("enable_hybrid_values.zig").EnableHybridValues;
const ExistCondition = @import("exist_condition.zig").ExistCondition;

pub const PutResourcePolicyInput = struct {
    /// If `'TRUE'`, indicates that you are using both methods to grant
    /// cross-account
    /// access to Data Catalog resources:
    ///
    /// * By directly updating the resource policy with `PutResourePolicy`
    ///
    /// * By using the **Grant permissions** command on the Amazon Web Services
    ///   Management Console.
    ///
    /// Must be set to `'TRUE'` if you have already used the Management Console to
    /// grant cross-account access, otherwise the call fails. Default is 'FALSE'.
    enable_hybrid: ?EnableHybridValues = null,

    /// A value of `MUST_EXIST` is used to update a policy. A value of
    /// `NOT_EXIST` is used to create a new policy. If a value of `NONE` or a
    /// null value is used, the call does not depend on the existence of a policy.
    policy_exists_condition: ?ExistCondition = null,

    /// The hash value returned when the previous policy was set using
    /// `PutResourcePolicy`. Its purpose is to prevent concurrent modifications of a
    /// policy. Do not use this parameter if no previous policy has been set.
    policy_hash_condition: ?[]const u8 = null,

    /// Contains the policy document to set, in JSON format.
    policy_in_json: []const u8,

    /// Do not use. For internal use only.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enable_hybrid = "EnableHybrid",
        .policy_exists_condition = "PolicyExistsCondition",
        .policy_hash_condition = "PolicyHashCondition",
        .policy_in_json = "PolicyInJson",
        .resource_arn = "ResourceArn",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// A hash of the policy that has just been set. This must
    /// be included in a subsequent call that overwrites or updates
    /// this policy.
    policy_hash: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_hash = "PolicyHash",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}
