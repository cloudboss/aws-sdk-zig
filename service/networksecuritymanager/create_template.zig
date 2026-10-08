const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleReference = @import("rule_reference.zig").RuleReference;
const TemplateFirewallType = @import("template_firewall_type.zig").TemplateFirewallType;
const AssociatedRule = @import("associated_rule.zig").AssociatedRule;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const CreateTemplateInput = struct {
    /// The rules associated with the template.
    associated_rule_list: []const RuleReference,

    /// A unique, case-sensitive token that you provide to ensure that the operation
    /// completes no more than one time. If you retry a request with the same client
    /// token and the same parameters, the service returns the result of the
    /// original successful request.
    client_token: ?[]const u8 = null,

    /// The firewall type associated with the resource.
    firewall_type: TemplateFirewallType,

    /// Specifies whether to publish the resource. When `true`, the resource is
    /// saved in published (`ACTIVE`) state. When `false`, it is saved as a draft
    /// (`DRAFT`). Default: `true`.
    is_published: ?bool = null,

    /// The tags to add to the resource when it is created.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A description of the template.
    template_description: ?[]const u8 = null,

    /// The name of the template.
    template_name: []const u8,

    pub const json_field_names = .{
        .associated_rule_list = "associatedRuleList",
        .client_token = "clientToken",
        .firewall_type = "firewallType",
        .is_published = "isPublished",
        .tags = "tags",
        .template_description = "templateDescription",
        .template_name = "templateName",
    };
};

pub const CreateTemplateOutput = struct {
    /// The rules associated with the template.
    associated_rule_list: ?[]const AssociatedRule = null,

    /// The firewall type associated with the resource.
    firewall_type: TemplateFirewallType,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// Specifies whether the resource is a snapshot of a published version.
    is_snapshot: ?bool = null,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: EntityStatus,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: []const u8,

    /// A description of the template.
    template_description: ?[]const u8 = null,

    /// The service-generated id of the template.
    template_id: []const u8,

    /// The name of the template.
    template_name: []const u8,

    /// The time when the resource was last updated.
    updated_at: ?i64 = null,

    /// A token used for optimistic concurrency control. Each read and write returns
    /// an `updateToken`. Provide the most recent value on your next update to
    /// detect and prevent conflicting concurrent modifications.
    update_token: ?[]const u8 = null,

    /// The version of the resource.
    version: []const u8,

    pub const json_field_names = .{
        .associated_rule_list = "associatedRuleList",
        .firewall_type = "firewallType",
        .has_published_version = "hasPublishedVersion",
        .is_snapshot = "isSnapshot",
        .status = "status",
        .template_arn = "templateArn",
        .template_description = "templateDescription",
        .template_id = "templateId",
        .template_name = "templateName",
        .updated_at = "updatedAt",
        .update_token = "updateToken",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTemplateInput, options: CallOptions) !CreateTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-security-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-security-manager", "Network Security Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/templates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"associatedRuleList\":");
    try aws.json.writeValue(@TypeOf(input.associated_rule_list), input.associated_rule_list, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"firewallType\":");
    try aws.json.writeValue(@TypeOf(input.firewall_type), input.firewall_type, allocator, &body_buf);
    has_prev = true;
    if (input.is_published) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isPublished\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.template_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"templateDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateName\":");
    try aws.json.writeValue(@TypeOf(input.template_name), input.template_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTemplateOutput {
    const result: CreateTemplateOutput = try aws.json.parseJsonObject(
        CreateTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
