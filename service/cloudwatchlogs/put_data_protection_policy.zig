const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutDataProtectionPolicyInput = struct {
    /// Specify either the log group name or log group ARN.
    log_group_identifier: []const u8,

    /// Specify the data protection policy, in JSON.
    ///
    /// This policy must include two JSON blocks:
    ///
    /// * The first block must include both a `DataIdentifer` array and an
    /// `Operation` property with an `Audit` action. The
    /// `DataIdentifer` array lists the types of sensitive data that you want to
    /// mask. For more information about the available options, see [Types of data
    /// that
    /// you can
    /// mask](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/mask-sensitive-log-data-types.html).
    ///
    /// The `Operation` property with an `Audit` action is required to
    /// find the sensitive data terms. This `Audit` action must contain a
    /// `FindingsDestination` object. You can optionally use that
    /// `FindingsDestination` object to list one or more destinations to send audit
    /// findings to. If you specify destinations such as log groups, Firehose
    /// streams,
    /// and S3 buckets, they must already exist.
    ///
    /// * The second block must include both a `DataIdentifer` array and an
    /// `Operation` property with an `Deidentify` action. The
    /// `DataIdentifer` array must exactly match the `DataIdentifer` array
    /// in the first block of the policy.
    ///
    /// The `Operation` property with the `Deidentify` action is what
    /// actually masks the data, and it must contain the ` "MaskConfig": {}` object.
    /// The ` "MaskConfig": {}` object must be empty.
    ///
    /// For an example data protection policy, see the **Examples**
    /// section on this page.
    ///
    /// The contents of the two `DataIdentifer` arrays must match exactly.
    ///
    /// In addition to the two JSON blocks, the `policyDocument` can also include
    /// `Name`, `Description`, and `Version` fields. The
    /// `Name` is used as a dimension when CloudWatch Logs reports audit findings
    /// metrics to CloudWatch.
    ///
    /// The JSON specified in `policyDocument` can be up to 30,720 characters.
    policy_document: []const u8,

    pub const json_field_names = .{
        .log_group_identifier = "logGroupIdentifier",
        .policy_document = "policyDocument",
    };
};

pub const PutDataProtectionPolicyOutput = struct {
    /// The date and time that this policy was most recently updated.
    last_updated_time: ?i64 = null,

    /// The log group name or ARN that you specified in your request.
    log_group_identifier: ?[]const u8 = null,

    /// The data protection policy used for this log group.
    policy_document: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_updated_time = "lastUpdatedTime",
        .log_group_identifier = "logGroupIdentifier",
        .policy_document = "policyDocument",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDataProtectionPolicyInput, options: CallOptions) !PutDataProtectionPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDataProtectionPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutDataProtectionPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDataProtectionPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutDataProtectionPolicyOutput, body, allocator);
}
