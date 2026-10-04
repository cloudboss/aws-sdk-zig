const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyType = @import("policy_type.zig").PolicyType;
const PolicySummary = @import("policy_summary.zig").PolicySummary;

pub const ListPoliciesForTargetInput = struct {
    /// The type of policy that you want to include in the returned list. You must
    /// specify one
    /// of the following values:
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
    filter: PolicyType,

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

    /// ID for the root, organizational unit, or account whose policies you want to
    /// list.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a target ID string
    /// requires one of the
    /// following:
    ///
    /// * **Root** - A string that begins with "r-" followed by from 4 to 32
    ///   lowercase letters or
    /// digits.
    ///
    /// * **Account** - A string that consists of exactly 12 digits.
    ///
    /// * **Organizational unit (OU)** - A string that begins with "ou-" followed by
    ///   from 4 to 32
    /// lowercase letters or digits (the ID of the root that the OU is in). This
    /// string is followed by a second
    /// "-" dash and from 8 to 32 additional lowercase letters or digits.
    target_id: []const u8,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .target_id = "TargetId",
    };
};

pub const ListPoliciesForTargetOutput = struct {
    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    /// The list of policies that match the criteria in the request.
    policies: ?[]const PolicySummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .policies = "Policies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPoliciesForTargetInput, options: CallOptions) !ListPoliciesForTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPoliciesForTargetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.ListPoliciesForTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPoliciesForTargetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPoliciesForTargetOutput, body, allocator);
}
