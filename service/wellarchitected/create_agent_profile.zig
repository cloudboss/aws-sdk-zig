const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationConfiguration = @import("aggregation_configuration.zig").AggregationConfiguration;
const Pillar = @import("pillar.zig").Pillar;
const Tag = @import("tag.zig").Tag;

pub const CreateAgentProfileInput = struct {
    /// The aggregation configuration that defines which Amazon Web Services
    /// accounts and Regions to analyze.
    aggregation_configuration: []const AggregationConfiguration,

    /// The business overview for this profile.
    business_overview: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// Indicates whether deletion protection is enabled for the profile.
    deletion_protection: ?bool = null,

    /// A description of the profile.
    description: ?[]const u8 = null,

    /// The display name of the profile shown to users.
    display_name: ?[]const u8 = null,

    /// The ARN of the IAM execution role used for recommendation actions.
    execution_role_arn: []const u8,

    /// The system name of the profile.
    name: []const u8,

    /// The Well-Architected Tool Framework pillars to associate with this profile.
    pillars: []const Pillar,

    /// The tags to associate with the profile.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aggregation_configuration = "aggregationConfiguration",
        .business_overview = "businessOverview",
        .client_token = "clientToken",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .display_name = "displayName",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .pillars = "pillars",
        .tags = "tags",
    };
};

pub const CreateAgentProfileOutput = struct {
    /// The aggregation configuration.
    aggregation_configuration: ?[]const AggregationConfiguration = null,

    /// The Amazon Resource Name (ARN) of the created profile.
    arn: []const u8,

    /// The business overview of the created profile.
    business_overview: ?[]const u8 = null,

    /// The timestamp when the profile was created.
    created_at: i64,

    /// The identifier of the user or system that created this profile.
    created_by: []const u8,

    /// Indicates whether deletion protection is enabled.
    deletion_protection: ?bool = null,

    /// A description of the created profile.
    description: ?[]const u8 = null,

    /// The display name of the created profile.
    display_name: ?[]const u8 = null,

    /// Indicates whether the profile is valid for manual architecture generation.
    eligible_for_architecture_generation: ?bool = null,

    /// Indicates whether the profile is valid for scheduled recommendation
    /// generation.
    eligible_for_scheduled_generation: ?bool = null,

    /// The ARN of the IAM execution role.
    execution_role_arn: []const u8,

    /// A map of field paths to error messages for invalid or missing input fields.
    field_errors: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the profile was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this profile.
    last_modified_by: ?[]const u8 = null,

    /// The system name of the created profile.
    name: []const u8,

    /// The Well-Architected Tool Framework pillars associated with the created
    /// profile.
    pillars: ?[]const Pillar = null,

    /// The tags associated with the created profile.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aggregation_configuration = "aggregationConfiguration",
        .arn = "arn",
        .business_overview = "businessOverview",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .display_name = "displayName",
        .eligible_for_architecture_generation = "eligibleForArchitectureGeneration",
        .eligible_for_scheduled_generation = "eligibleForScheduledGeneration",
        .execution_role_arn = "executionRoleArn",
        .field_errors = "fieldErrors",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .name = "name",
        .pillars = "pillars",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAgentProfileInput, options: CallOptions) !CreateAgentProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAgentProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/v1/agent-profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_configuration), input.aggregation_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.business_overview) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"businessOverview\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deletion_protection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletionProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"pillars\":");
    try aws.json.writeValue(@TypeOf(input.pillars), input.pillars, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAgentProfileOutput {
    const result: CreateAgentProfileOutput = try aws.json.parseJsonObject(
        CreateAgentProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
