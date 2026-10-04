const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EffectivePolicyType = @import("effective_policy_type.zig").EffectivePolicyType;
const EffectivePolicy = @import("effective_policy.zig").EffectivePolicy;

pub const DescribeEffectivePolicyInput = struct {
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
    ///
    /// *
    ///   [GUARDDUTY_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_guardduty.html)
    policy_type: EffectivePolicyType,

    /// When you're signed in as the management account, specify the ID of the
    /// account that
    /// you want details about. Specifying an organization root or organizational
    /// unit (OU) as
    /// the target is not supported.
    target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_type = "PolicyType",
        .target_id = "TargetId",
    };
};

pub const DescribeEffectivePolicyOutput = struct {
    /// The contents of the effective policy.
    effective_policy: ?EffectivePolicy = null,

    pub const json_field_names = .{
        .effective_policy = "EffectivePolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEffectivePolicyInput, options: CallOptions) !DescribeEffectivePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEffectivePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.DescribeEffectivePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEffectivePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEffectivePolicyOutput, body, allocator);
}
