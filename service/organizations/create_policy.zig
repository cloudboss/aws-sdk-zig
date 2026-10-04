const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const PolicyType = @import("policy_type.zig").PolicyType;
const Policy = @import("policy.zig").Policy;

pub const CreatePolicyInput = struct {
    /// The policy text content to add to the new policy. The text that you supply
    /// must adhere
    /// to the rules of the policy type you specify in the `Type` parameter.
    ///
    /// The maximum size of a policy document depends on the policy's type. For more
    /// information, see [Maximum and minimum
    /// values](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_limits.html#min-max-values) in the
    /// *Organizations User Guide*.
    content: []const u8,

    /// An optional description to assign to the policy.
    description: []const u8,

    /// The friendly name to assign to the policy.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: []const u8,

    /// A list of tags that you want to attach to the newly created policy. For each
    /// tag in
    /// the list, you must specify both a tag key and a value. You can set the value
    /// to an empty
    /// string, but you can't set it to `null`. For more information about tagging,
    /// see [Tagging Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the Organizations User Guide.
    ///
    /// If any one of the tags is not valid or if you exceed the allowed number of
    /// tags
    /// for a policy, then the entire request fails and the policy is not created.
    tags: ?[]const Tag = null,

    /// The type of policy to create. You can specify one of the following values:
    ///
    /// *
    ///   [SERVICE_CONTROL_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html)
    ///
    /// *
    ///   [RESOURCE_CONTROL_POLICY](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_rcps.html)
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
    @"type": PolicyType,

    pub const json_field_names = .{
        .content = "Content",
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub const CreatePolicyOutput = struct {
    /// A structure that contains details about the newly created policy.
    policy: ?Policy = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyInput, options: CallOptions) !CreatePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.CreatePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePolicyOutput, body, allocator);
}
