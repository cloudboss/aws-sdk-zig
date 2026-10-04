const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentAvailabilityTimer = @import("agent_availability_timer.zig").AgentAvailabilityTimer;
const RoutingProfileManualAssignmentQueueConfig = @import("routing_profile_manual_assignment_queue_config.zig").RoutingProfileManualAssignmentQueueConfig;
const MediaConcurrency = @import("media_concurrency.zig").MediaConcurrency;
const RoutingProfileQueueConfig = @import("routing_profile_queue_config.zig").RoutingProfileQueueConfig;

pub const CreateRoutingProfileInput = struct {
    /// Whether agents with this routing profile will have their routing order
    /// calculated based on *longest
    /// idle time* or *time since their last inbound contact*.
    agent_availability_timer: ?AgentAvailabilityTimer = null,

    /// The default outbound queue for the routing profile.
    default_outbound_queue_id: []const u8,

    /// Description of the routing profile. Must not be more than 250 characters.
    description: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The manual assignment queues associated with the routing profile. If no
    /// queue is added, agents and supervisors
    /// can't pick or assign any contacts from this routing profile. The limit of 10
    /// array members applies to the maximum
    /// number of RoutingProfileManualAssignmentQueueConfig objects that can be
    /// passed during a CreateRoutingProfile API
    /// request. It is different from the quota of 50 queues per routing profile per
    /// instance that is listed in Amazon Connect service quotas.
    ///
    /// Note: Use this config for chat, email, and task contacts. It does not
    /// support voice contacts.
    manual_assignment_queue_configs: ?[]const RoutingProfileManualAssignmentQueueConfig = null,

    /// The channels that agents can handle in the Contact Control Panel (CCP) for
    /// this routing profile.
    media_concurrencies: []const MediaConcurrency,

    /// The name of the routing profile. Must not be more than 127 characters.
    name: []const u8,

    /// The inbound queues associated with the routing profile. If no queue is
    /// added, the agent can make only outbound
    /// calls.
    ///
    /// The limit of 10 array members applies to the maximum number of
    /// `RoutingProfileQueueConfig` objects
    /// that can be passed during a CreateRoutingProfile API request. It is
    /// different from the quota of 50 queues per routing
    /// profile per instance that is listed in [Amazon Connect service
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html).
    queue_configs: ?[]const RoutingProfileQueueConfig = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_availability_timer = "AgentAvailabilityTimer",
        .default_outbound_queue_id = "DefaultOutboundQueueId",
        .description = "Description",
        .instance_id = "InstanceId",
        .manual_assignment_queue_configs = "ManualAssignmentQueueConfigs",
        .media_concurrencies = "MediaConcurrencies",
        .name = "Name",
        .queue_configs = "QueueConfigs",
        .tags = "Tags",
    };
};

pub const CreateRoutingProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the routing profile.
    routing_profile_arn: ?[]const u8 = null,

    /// The identifier of the routing profile.
    routing_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .routing_profile_arn = "RoutingProfileArn",
        .routing_profile_id = "RoutingProfileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRoutingProfileInput, options: CallOptions) !CreateRoutingProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRoutingProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/routing-profiles/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.agent_availability_timer) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AgentAvailabilityTimer\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DefaultOutboundQueueId\":");
    try aws.json.writeValue(@TypeOf(input.default_outbound_queue_id), input.default_outbound_queue_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (input.manual_assignment_queue_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ManualAssignmentQueueConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MediaConcurrencies\":");
    try aws.json.writeValue(@TypeOf(input.media_concurrencies), input.media_concurrencies, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.queue_configs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueueConfigs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRoutingProfileOutput {
    var result: CreateRoutingProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRoutingProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
