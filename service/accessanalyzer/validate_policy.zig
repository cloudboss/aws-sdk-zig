const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Locale = @import("locale.zig").Locale;
const PolicyType = @import("policy_type.zig").PolicyType;
const ValidatePolicyResourceType = @import("validate_policy_resource_type.zig").ValidatePolicyResourceType;
const ValidatePolicyFinding = @import("validate_policy_finding.zig").ValidatePolicyFinding;

pub const ValidatePolicyInput = struct {
    /// The locale to use for localizing the findings.
    locale: ?Locale = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    /// The JSON policy document to use as the content for the policy.
    policy_document: []const u8,

    /// The type of policy to validate. Identity policies grant permissions to IAM
    /// principals. Identity policies include managed and inline policies for IAM
    /// roles, users, and groups.
    ///
    /// Resource policies grant permissions on Amazon Web Services resources.
    /// Resource policies include trust policies for IAM roles and bucket policies
    /// for Amazon S3 buckets. You can provide a generic input such as identity
    /// policy or resource policy or a specific input such as managed policy or
    /// Amazon S3 bucket policy.
    ///
    /// Service control policies (SCPs) are a type of organization policy attached
    /// to an Amazon Web Services organization, organizational unit (OU), or an
    /// account.
    policy_type: PolicyType,

    /// The type of resource to attach to your resource policy. Specify a value for
    /// the policy validation resource type only if the policy type is
    /// `RESOURCE_POLICY`. For example, to validate a resource policy to attach to
    /// an Amazon S3 bucket, you can choose `AWS::S3::Bucket` for the policy
    /// validation resource type.
    ///
    /// For resource types not supported as valid values, IAM Access Analyzer runs
    /// policy checks that apply to all resource policies. For example, to validate
    /// a resource policy to attach to a KMS key, do not specify a value for the
    /// policy validation resource type and IAM Access Analyzer will run policy
    /// checks that apply to all resource policies.
    validate_policy_resource_type: ?ValidatePolicyResourceType = null,

    pub const json_field_names = .{
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .policy_document = "policyDocument",
        .policy_type = "policyType",
        .validate_policy_resource_type = "validatePolicyResourceType",
    };
};

pub const ValidatePolicyOutput = struct {
    /// The list of findings in a policy returned by IAM Access Analyzer based on
    /// its suite of policy checks.
    findings: ?[]const ValidatePolicyFinding = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings = "findings",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidatePolicyInput, options: CallOptions) !ValidatePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policy/validation";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.locale) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"locale\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyType\":");
    try aws.json.writeValue(@TypeOf(input.policy_type), input.policy_type, allocator, &body_buf);
    has_prev = true;
    if (input.validate_policy_resource_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"validatePolicyResourceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidatePolicyOutput {
    var result: ValidatePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ValidatePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
