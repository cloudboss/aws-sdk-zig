const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const LockConfiguration = @import("lock_configuration.zig").LockConfiguration;
const ResourceType = @import("resource_type.zig").ResourceType;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const Tag = @import("tag.zig").Tag;
const LockState = @import("lock_state.zig").LockState;
const RuleStatus = @import("rule_status.zig").RuleStatus;

pub const CreateRuleInput = struct {
    /// The retention rule description.
    description: ?[]const u8 = null,

    /// [Region-level retention rules only] Specifies the exclusion tags to use to
    /// identify resources that are to be excluded,
    /// or ignored, by a Region-level retention rule. Resources that have any of
    /// these tags are not retained by the retention rule
    /// upon deletion.
    ///
    /// You can't specify exclusion tags for tag-level retention rules.
    exclude_resource_tags: ?[]const ResourceTag = null,

    /// Information about the retention rule lock configuration.
    lock_configuration: ?LockConfiguration = null,

    /// [Tag-level retention rules only] Specifies the resource tags to use to
    /// identify resources that are to be retained by a
    /// tag-level retention rule. For tag-level retention rules, only deleted
    /// resources, of the specified resource type, that
    /// have one or more of the specified tag key and value pairs are retained. If a
    /// resource is deleted, but it does not have
    /// any of the specified tag key and value pairs, it is immediately deleted
    /// without being retained by the retention rule.
    ///
    /// You can add the same tag key and value pair to a maximum or five retention
    /// rules.
    ///
    /// To create a Region-level retention rule, omit this parameter. A Region-level
    /// retention rule
    /// does not have any resource tags specified. It retains all deleted resources
    /// of the specified
    /// resource type in the Region in which the rule is created, even if the
    /// resources are not tagged.
    resource_tags: ?[]const ResourceTag = null,

    /// The resource type to be retained by the retention rule. Currently, only EBS
    /// volumes, EBS snapshots, and EBS-backed AMIs
    /// are supported.
    ///
    /// * To retain EBS volumes, specify `EBS_VOLUME`.
    ///
    /// * To retain EBS snapshots, specify `EBS_SNAPSHOT`
    ///
    /// * To retain EBS-backed AMIs, specify `EC2_IMAGE`.
    resource_type: ResourceType,

    /// Information about the retention period for which the retention rule is to
    /// retain resources.
    retention_period: RetentionPeriod,

    /// Information about the tags to assign to the retention rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .lock_configuration = "LockConfiguration",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
        .tags = "Tags",
    };
};

pub const CreateRuleOutput = struct {
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

    /// Information about the tags assigned to the retention rule.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .exclude_resource_tags = "ExcludeResourceTags",
        .identifier = "Identifier",
        .lock_configuration = "LockConfiguration",
        .lock_state = "LockState",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .retention_period = "RetentionPeriod",
        .rule_arn = "RuleArn",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleInput, options: CallOptions) !CreateRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rbin", "rbin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/rules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exclude_resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExcludeResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lock_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LockConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceType\":");
    try aws.json.writeValue(@TypeOf(input.resource_type), input.resource_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RetentionPeriod\":");
    try aws.json.writeValue(@TypeOf(input.retention_period), input.retention_period, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRuleOutput {
    const result: CreateRuleOutput = try aws.json.parseJsonObject(
        CreateRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
