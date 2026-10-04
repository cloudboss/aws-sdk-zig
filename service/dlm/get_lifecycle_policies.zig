const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefaultPoliciesTypeValues = @import("default_policies_type_values.zig").DefaultPoliciesTypeValues;
const ResourceTypeValues = @import("resource_type_values.zig").ResourceTypeValues;
const GettablePolicyStateValues = @import("gettable_policy_state_values.zig").GettablePolicyStateValues;
const LifecyclePolicySummary = @import("lifecycle_policy_summary.zig").LifecyclePolicySummary;

pub const GetLifecyclePoliciesInput = struct {
    /// **[Default policies only]** Specifies the type of default policy to get.
    /// Specify one of the following:
    ///
    /// * `VOLUME` - To get only the default policy for EBS snapshots
    ///
    /// * `INSTANCE` - To get only the default policy for EBS-backed AMIs
    ///
    /// * `ALL` - To get all default policies
    default_policy_type: ?DefaultPoliciesTypeValues = null,

    /// The identifiers of the data lifecycle policies.
    policy_ids: ?[]const []const u8 = null,

    /// The resource type.
    resource_types: ?[]const ResourceTypeValues = null,

    /// The activation state.
    state: ?GettablePolicyStateValues = null,

    /// The tags to add to objects created by the policy.
    ///
    /// Tags are strings in the format `key=value`.
    ///
    /// These user-defined tags are added in addition to the Amazon Web
    /// Services-added lifecycle tags.
    tags_to_add: ?[]const []const u8 = null,

    /// The target tag for a policy.
    ///
    /// Tags are strings in the format `key=value`.
    target_tags: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .default_policy_type = "DefaultPolicyType",
        .policy_ids = "PolicyIds",
        .resource_types = "ResourceTypes",
        .state = "State",
        .tags_to_add = "TagsToAdd",
        .target_tags = "TargetTags",
    };
};

pub const GetLifecyclePoliciesOutput = struct {
    /// Summary information about the lifecycle policies.
    policies: ?[]const LifecyclePolicySummary = null,

    pub const json_field_names = .{
        .policies = "Policies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLifecyclePoliciesInput, options: CallOptions) !GetLifecyclePoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dlm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLifecyclePoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dlm", "DLM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policies";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.default_policy_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "defaultPolicyType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.policy_ids) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "policyIds=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.resource_types) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "resourceTypes=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "state=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.tags_to_add) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "tagsToAdd=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.target_tags) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "targetTags=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLifecyclePoliciesOutput {
    var result: GetLifecyclePoliciesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLifecyclePoliciesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
