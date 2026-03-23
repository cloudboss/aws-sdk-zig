const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dlm");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetLifecyclePoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dlm", "DLM", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/policies";

    var query_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
