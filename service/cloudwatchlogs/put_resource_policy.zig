const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyInput = struct {
    /// The expected revision ID of the resource policy. Required when `resourceArn`
    /// is
    /// provided to prevent concurrent modifications. Use `null` when creating a
    /// resource
    /// policy for the first time.
    expected_revision_id: ?[]const u8 = null,

    /// Details of the new policy, including the identity of the principal that is
    /// enabled to
    /// put logs to this account. This is formatted as a JSON string. This parameter
    /// is
    /// required.
    ///
    /// The following example creates a resource policy enabling the Route 53
    /// service to put
    /// DNS query logs in to the specified log group. Replace `"logArn"` with the
    /// ARN of
    /// your CloudWatch Logs resource, such as a log group or log stream.
    ///
    /// CloudWatch Logs also supports
    /// [aws:SourceArn](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-sourcearn) and [aws:SourceAccount](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-sourceaccount) condition context keys.
    ///
    /// In the example resource policy, you would replace the value of `SourceArn`
    /// with
    /// the resource making the call from Route 53 to CloudWatch Logs. You would
    /// also
    /// replace the value of `SourceAccount` with the Amazon Web Services account ID
    /// making
    /// that call.
    ///
    /// `{ "Version": "2012-10-17", "Statement": [ { "Sid":
    /// "Route53LogsToCloudWatchLogs", "Effect": "Allow", "Principal": { "Service":
    /// [
    /// "route53.amazonaws.com" ] }, "Action": "logs:PutLogEvents", "Resource":
    /// "logArn",
    /// "Condition": { "ArnLike": { "aws:SourceArn": "myRoute53ResourceArn" },
    /// "StringEquals": {
    /// "aws:SourceAccount": "myAwsAccountId" } } } ] }`
    policy_document: ?[]const u8 = null,

    /// Name of the new policy. This parameter is required.
    policy_name: ?[]const u8 = null,

    /// The ARN of the CloudWatch Logs resource to which the resource policy needs
    /// to be added
    /// or attached. Currently only supports LogGroup ARN.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .expected_revision_id = "expectedRevisionId",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .resource_arn = "resourceArn",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The new policy.
    resource_policy: ?ResourcePolicy = null,

    /// The revision ID of the created or updated resource policy. Only returned for
    /// resource-scoped policies.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_policy = "resourcePolicy",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}
