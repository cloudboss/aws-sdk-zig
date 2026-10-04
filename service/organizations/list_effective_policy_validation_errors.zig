const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EffectivePolicyType = @import("effective_policy_type.zig").EffectivePolicyType;
const EffectivePolicyValidationError = @import("effective_policy_validation_error.zig").EffectivePolicyValidationError;

pub const ListEffectivePolicyValidationErrorsInput = struct {
    /// The ID of the account that you want details about. Specifying an
    /// organization root or
    /// organizational unit (OU) as the target is not supported.
    account_id: []const u8,

    /// The maximum number of items to return in the response. If more results exist
    /// than the specified `MaxResults` value, a token is included in the response
    /// so that you can retrieve the remaining results.
    max_results: ?i32 = null,

    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken` response
    /// indicates that more output is available. Set this parameter to the value of
    /// the previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    /// The type of policy that you want information about. You can specify one of
    /// the
    /// following values:
    ///
    /// *
    ///   [DECLARATIVE_POLICY_EC2](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative.html)
    ///
    /// *
    ///   [BACKUP_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_backup.html)
    ///
    /// *
    ///   [TAG_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies.html)
    ///
    /// *
    ///   [CHATBOT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_chatbot.html)
    ///
    /// *
    ///   [AISERVICES_OPT_OUT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_ai-opt-out.html)
    ///
    /// *
    ///   [SECURITYHUB_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_security_hub.html)
    ///
    /// *
    ///   [UPGRADE_ROLLOUT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_upgrade_rollout.html)
    ///
    /// *
    ///   [INSPECTOR_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_inspector.html)
    ///
    /// *
    ///   [BEDROCK_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_bedrock.html)
    ///
    /// *
    ///   [S3_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_s3.html)
    ///
    /// *
    ///   [NETWORK_SECURITY_DIRECTOR_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_network_security_director.html)
    policy_type: EffectivePolicyType,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .policy_type = "PolicyType",
    };
};

pub const ListEffectivePolicyValidationErrorsOutput = struct {
    /// The ID of the specified account.
    account_id: ?[]const u8 = null,

    /// The `EffectivePolicyValidationError` object contains details about the
    /// validation errors that occurred when generating or enforcing an effective
    /// policy, such
    /// as which policies contributed to the error and location of the error.
    effective_policy_validation_errors: ?[]const EffectivePolicyValidationError = null,

    /// The time when the latest effective policy was generated for the specified
    /// account.
    evaluation_timestamp: ?i64 = null,

    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    /// The path in the organization where the specified account exists.
    path: ?[]const u8 = null,

    /// The specified policy type. One of the following values:
    ///
    /// *
    ///   [DECLARATIVE_POLICY_EC2](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative.html)
    ///
    /// *
    ///   [BACKUP_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_backup.html)
    ///
    /// *
    ///   [TAG_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_tag-policies.html)
    ///
    /// *
    ///   [CHATBOT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_chatbot.html)
    ///
    /// *
    ///   [AISERVICES_OPT_OUT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_ai-opt-out.html)
    ///
    /// *
    ///   [SECURITYHUB_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_security_hub.html)
    ///
    /// *
    ///   [UPGRADE_ROLLOUT_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_upgrade_rollout.html)
    ///
    /// *
    ///   [INSPECTOR_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_inspector.html)
    ///
    /// *
    ///   [BEDROCK_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_bedrock.html)
    ///
    /// *
    ///   [S3_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_s3.html)
    ///
    /// *
    ///   [NETWORK_SECURITY_DIRECTOR_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_network_security_director.html)
    policy_type: ?EffectivePolicyType = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .effective_policy_validation_errors = "EffectivePolicyValidationErrors",
        .evaluation_timestamp = "EvaluationTimestamp",
        .next_token = "NextToken",
        .path = "Path",
        .policy_type = "PolicyType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEffectivePolicyValidationErrorsInput, options: CallOptions) !ListEffectivePolicyValidationErrorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEffectivePolicyValidationErrorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.ListEffectivePolicyValidationErrors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEffectivePolicyValidationErrorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEffectivePolicyValidationErrorsOutput, body, allocator);
}
