const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThreatAnchorShape = @import("threat_anchor_shape.zig").ThreatAnchorShape;
const ThreatEvidenceShape = @import("threat_evidence_shape.zig").ThreatEvidenceShape;
const ThreatSeverity = @import("threat_severity.zig").ThreatSeverity;
const ThreatStatus = @import("threat_status.zig").ThreatStatus;
const ThreatActor = @import("threat_actor.zig").ThreatActor;
const StrideCategory = @import("stride_category.zig").StrideCategory;

pub const UpdateThreatInput = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// The updated DFD element this threat is anchored to.
    anchor: ?ThreatAnchorShape = null,

    /// Optional customer comment.
    comments: ?[]const u8 = null,

    /// The updated source code files supporting the threat.
    evidence: ?[]const ThreatEvidenceShape = null,

    /// The updated list of specific assets affected by the threat.
    impacted_assets: ?[]const []const u8 = null,

    /// The updated security goals affected by the threat.
    impacted_goal: ?[]const []const u8 = null,

    /// The updated conditions required for the threat to be exploitable.
    prerequisites: ?[]const u8 = null,

    /// The updated recommended mitigation guidance for this threat.
    recommendation: ?[]const u8 = null,

    /// The updated severity level of the threat.
    severity: ?ThreatSeverity = null,

    /// The updated natural-language threat statement.
    statement: ?[]const u8 = null,

    /// The updated status of the threat.
    status: ?ThreatStatus = null,

    /// The updated description of what the threat source can do.
    threat_action: ?[]const u8 = null,

    /// The unique identifier of the threat to update.
    threat_id: []const u8,

    /// The updated direct consequence of the threat action.
    threat_impact: ?[]const u8 = null,

    /// The updated actor or origin of the threat.
    threat_source: ?[]const u8 = null,

    /// A short title summarizing the threat.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .anchor = "anchor",
        .comments = "comments",
        .evidence = "evidence",
        .impacted_assets = "impactedAssets",
        .impacted_goal = "impactedGoal",
        .prerequisites = "prerequisites",
        .recommendation = "recommendation",
        .severity = "severity",
        .statement = "statement",
        .status = "status",
        .threat_action = "threatAction",
        .threat_id = "threatId",
        .threat_impact = "threatImpact",
        .threat_source = "threatSource",
        .title = "title",
    };
};

pub const UpdateThreatOutput = struct {
    /// The DFD element this threat is anchored to.
    anchor: ?ThreatAnchorShape = null,

    /// Optional customer comment on the threat.
    comments: ?[]const u8 = null,

    /// The date and time the threat was created, in UTC format.
    created_at: ?i64 = null,

    /// Who created this threat.
    created_by: ?ThreatActor = null,

    /// The source code files supporting the threat.
    evidence: ?[]const ThreatEvidenceShape = null,

    /// The specific assets affected by the threat.
    impacted_assets: ?[]const []const u8 = null,

    /// The security goals affected by the threat.
    impacted_goal: ?[]const []const u8 = null,

    /// The conditions required for the threat to be exploitable.
    prerequisites: ?[]const u8 = null,

    /// The recommended mitigation guidance for this threat.
    recommendation: ?[]const u8 = null,

    /// The severity level of the threat.
    severity: ?ThreatSeverity = null,

    /// The natural-language threat statement.
    statement: ?[]const u8 = null,

    /// The current status of the threat.
    status: ?ThreatStatus = null,

    /// The STRIDE categories applicable to this threat.
    stride: ?[]const StrideCategory = null,

    /// What the threat source can do.
    threat_action: ?[]const u8 = null,

    /// The unique identifier of the threat.
    threat_id: []const u8,

    /// The direct consequence of the threat action.
    threat_impact: ?[]const u8 = null,

    /// The unique identifier of the threat model job the threat belongs to.
    threat_job_id: []const u8,

    /// The actor or origin of the threat.
    threat_source: ?[]const u8 = null,

    /// A short title summarizing the threat.
    title: ?[]const u8 = null,

    /// The date and time the threat was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// Who last updated this threat.
    updated_by: ?ThreatActor = null,

    pub const json_field_names = .{
        .anchor = "anchor",
        .comments = "comments",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .evidence = "evidence",
        .impacted_assets = "impactedAssets",
        .impacted_goal = "impactedGoal",
        .prerequisites = "prerequisites",
        .recommendation = "recommendation",
        .severity = "severity",
        .statement = "statement",
        .status = "status",
        .stride = "stride",
        .threat_action = "threatAction",
        .threat_id = "threatId",
        .threat_impact = "threatImpact",
        .threat_job_id = "threatJobId",
        .threat_source = "threatSource",
        .title = "title",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateThreatInput, options: CallOptions) !UpdateThreatOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateThreatInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateThreat";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (input.anchor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"anchor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.comments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evidence) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evidence\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_assets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedAssets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_goal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedGoal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prerequisites) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"prerequisites\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recommendation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recommendation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.severity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"severity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.statement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"statement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.threat_action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"threatAction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"threatId\":");
    try aws.json.writeValue(@TypeOf(input.threat_id), input.threat_id, allocator, &body_buf);
    has_prev = true;
    if (input.threat_impact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"threatImpact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.threat_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"threatSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"title\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateThreatOutput {
    const result: UpdateThreatOutput = try aws.json.parseJsonObject(
        UpdateThreatOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
