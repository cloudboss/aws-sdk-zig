const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const LockConfiguration = @import("lock_configuration.zig").LockConfiguration;
const LockState = @import("lock_state.zig").LockState;
const ResourceType = @import("resource_type.zig").ResourceType;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const RuleStatus = @import("rule_status.zig").RuleStatus;

pub const UnlockRuleInput = struct {
    /// The unique ID of the retention rule.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const UnlockRuleOutput = struct {
    /// The retention rule description.
    description: ?[]const u8 = null,

    /// [Region-level retention rules only] Information about the exclusion tags
    /// used to identify resources that are to be
    /// excluded, or ignored, by the retention rule.
    exclude_resource_tags: ?[]const ResourceTag = null,

    /// The unique ID of the retention rule.
    identifier: ?[]const u8 = null,

    /// Information about the retention rule lock configuration.
    lock_configuration: ?LockConfiguration = null,

    /// The date and time at which the unlock delay is set to expire. Only returned
    /// for retention rules that have been unlocked and that are still within the
    /// unlock
    /// delay period.
    lock_end_time: ?i64 = null,

    /// [Region-level retention rules only] The lock state for the retention rule.
    ///
    /// * `locked` - The retention rule is locked and can't be modified or deleted.
    ///
    /// * `pending_unlock` - The retention rule has been unlocked but it is still
    ///   within
    /// the unlock delay period. The retention rule can be modified or deleted only
    /// after the unlock
    /// delay period has expired.
    ///
    /// * `unlocked` - The retention rule is unlocked and it can be modified or
    ///   deleted by
    /// any user with the required permissions.
    ///
    /// * `null` - The retention rule has never been locked. Once a retention rule
    ///   has
    /// been locked, it can transition between the `locked` and `unlocked` states
    /// only; it can never transition back to `null`.
    lock_state: ?LockState = null,

    /// [Tag-level retention rules only] Information about the resource tags used to
    /// identify resources that are retained by the retention
    /// rule.
    resource_tags: ?[]const ResourceTag = null,

    /// The resource type retained by the retention rule.
    resource_type: ?ResourceType = null,

    retention_period: ?RetentionPeriod = null,

    /// The Amazon Resource Name (ARN) of the retention rule.
    rule_arn: ?[]const u8 = null,

    /// The state of the retention rule. Only retention rules that are in the
    /// `available`
    /// state retain resources.
    status: ?RuleStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .identifier = "Identifier",
        .lock_configuration = "LockConfiguration",
        .lock_end_time = "LockEndTime",
        .lock_state = "LockState",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
        .rule_arn = "RuleArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UnlockRuleInput, options: CallOptions) !UnlockRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rbin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UnlockRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rbin", "rbin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/unlock");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UnlockRuleOutput {
    var result: UnlockRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UnlockRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
