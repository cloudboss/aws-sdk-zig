const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePolicyInput = struct {
    /// The revision ID that Amazon Comprehend assigned to the policy that you are
    /// updating. If
    /// you are creating a new policy that has no prior version, don't use this
    /// parameter. Amazon
    /// Comprehend creates the revision ID for you.
    policy_revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the custom model to attach the policy to.
    resource_arn: []const u8,

    /// The JSON resource-based policy to attach to your custom model. Provide your
    /// JSON as a
    /// UTF-8 encoded string without line breaks. To provide valid JSON for your
    /// policy, enclose the
    /// attribute names and values in double quotes. If the JSON body is also
    /// enclosed in double
    /// quotes, then you must escape the double quotes that are inside the policy:
    ///
    /// `"{\"attribute\": \"value\", \"attribute\": [\"value\"]}"`
    ///
    /// To avoid escaping quotes, you can use single quotes to enclose the policy
    /// and double
    /// quotes to enclose the JSON names and values:
    ///
    /// `'{"attribute": "value", "attribute": ["value"]}'`
    resource_policy: []const u8,

    pub const json_field_names = .{
        .policy_revision_id = "PolicyRevisionId",
        .resource_arn = "ResourceArn",
        .resource_policy = "ResourcePolicy",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The revision ID of the policy. Each time you modify a policy, Amazon
    /// Comprehend assigns a
    /// new revision ID, and it deletes the prior version of the policy.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_revision_id = "PolicyRevisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}
