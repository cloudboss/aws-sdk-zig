const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIAgent = @import("ai_agent.zig").AIAgent;
const FlowModule = @import("flow_module.zig").FlowModule;
const Application = @import("application.zig").Application;
const GranularAccessControlConfiguration = @import("granular_access_control_configuration.zig").GranularAccessControlConfiguration;

pub const CreateSecurityProfileInput = struct {
    /// The identifier of the hierarchy group that a security profile uses to
    /// restrict access to resources in Connect Customer.
    allowed_access_control_hierarchy_group_id: ?[]const u8 = null,

    /// The list of tags that a security profile uses to restrict access to
    /// resources in Connect Customer.
    allowed_access_control_tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of AI agents that the security profile will give access to.
    allowed_ai_agents: ?[]const AIAgent = null,

    /// A list of Flow Modules an AI Agent can invoke as a tool.
    allowed_flow_modules: ?[]const FlowModule = null,

    /// A list of third-party applications or MCP Servers that the security profile
    /// will give access to.
    applications: ?[]const Application = null,

    /// The description of the security profile.
    description: ?[]const u8 = null,

    /// The granular access control configuration for the security profile,
    /// including data table permissions.
    granular_access_control_configuration: ?GranularAccessControlConfiguration = null,

    /// The list of resources that a security profile applies hierarchy restrictions
    /// to in Connect Customer. Following
    /// are acceptable ResourceNames: `User`.
    hierarchy_restricted_resources: ?[]const []const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// Permissions assigned to the security profile. For a list of valid
    /// permissions, see [List of security profile
    /// permissions](https://docs.aws.amazon.com/connect/latest/adminguide/security-profile-list.html).
    permissions: ?[]const []const u8 = null,

    /// The name of the security profile.
    security_profile_name: []const u8,

    /// The list of resources that a security profile applies tag restrictions to in
    /// Connect Customer. For a list of Connect Customer resources that you can tag,
    /// see [Add tags to resources in Connect
    /// Customer](https://docs.aws.amazon.com/connect/latest/adminguide/tagging.html) in the *Connect Customer Administrator Guide*.
    tag_restricted_resources: ?[]const []const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allowed_access_control_hierarchy_group_id = "AllowedAccessControlHierarchyGroupId",
        .allowed_access_control_tags = "AllowedAccessControlTags",
        .allowed_ai_agents = "AllowedAIAgents",
        .allowed_flow_modules = "AllowedFlowModules",
        .applications = "Applications",
        .description = "Description",
        .granular_access_control_configuration = "GranularAccessControlConfiguration",
        .hierarchy_restricted_resources = "HierarchyRestrictedResources",
        .instance_id = "InstanceId",
        .permissions = "Permissions",
        .security_profile_name = "SecurityProfileName",
        .tag_restricted_resources = "TagRestrictedResources",
        .tags = "Tags",
    };
};

pub const CreateSecurityProfileOutput = struct {
    /// The Amazon Resource Name (ARN) for the security profile.
    security_profile_arn: ?[]const u8 = null,

    /// The identifier for the security profle.
    security_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_profile_arn = "SecurityProfileArn",
        .security_profile_id = "SecurityProfileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSecurityProfileInput, options: CallOptions) !CreateSecurityProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSecurityProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/security-profiles/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_access_control_hierarchy_group_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedAccessControlHierarchyGroupId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.allowed_access_control_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedAccessControlTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.allowed_ai_agents) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedAIAgents\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.allowed_flow_modules) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedFlowModules\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.applications) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Applications\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.granular_access_control_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GranularAccessControlConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hierarchy_restricted_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HierarchyRestrictedResources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecurityProfileName\":");
    try aws.json.writeValue(@TypeOf(input.security_profile_name), input.security_profile_name, allocator, &body_buf);
    has_prev = true;
    if (input.tag_restricted_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagRestrictedResources\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSecurityProfileOutput {
    const result: CreateSecurityProfileOutput = try aws.json.parseJsonObject(
        CreateSecurityProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
