const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexPolicy = @import("index_policy.zig").IndexPolicy;

pub const PutIndexPolicyInput = struct {
    /// Specify either the log group name or log group ARN to apply this field index
    /// policy to. If
    /// you specify an ARN, use the format
    /// arn:aws:logs:*region*:*account-id*:log-group:*log_group_name*
    /// Don't include an * at the end.
    log_group_identifier: []const u8,

    /// The index policy document, in JSON format. The following is an example of an
    /// index policy
    /// document that creates indexes with different types.
    ///
    /// `"policyDocument": "{"Fields": [ "TransactionId" ], "FieldsV2":
    /// {"RequestId":
    /// {"type": "FIELD_INDEX"}, "APIName": {"type": "FACET"}, "StatusCode":
    /// {"type":
    /// "FACET"}}}"`
    ///
    /// You can use `FieldsV2` to specify the type for each field. Supported types
    /// are
    /// `FIELD_INDEX` and `FACET`. Field names within `Fields` and
    /// `FieldsV2` must be mutually exclusive.
    ///
    /// The policy document must include at least one field index. For more
    /// information about the
    /// fields that can be included and other restrictions, see [Field index
    /// syntax and
    /// quotas](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing-Syntax.html).
    policy_document: []const u8,

    pub const json_field_names = .{
        .log_group_identifier = "logGroupIdentifier",
        .policy_document = "policyDocument",
    };
};

pub const PutIndexPolicyOutput = struct {
    /// The index policy that you just created or updated.
    index_policy: ?IndexPolicy = null,

    pub const json_field_names = .{
        .index_policy = "indexPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIndexPolicyInput, options: CallOptions) !PutIndexPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutIndexPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutIndexPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIndexPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutIndexPolicyOutput, body, allocator);
}
