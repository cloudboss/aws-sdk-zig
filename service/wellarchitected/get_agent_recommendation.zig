const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RemediationType = @import("remediation_type.zig").RemediationType;
const CrossPillarBenefit = @import("cross_pillar_benefit.zig").CrossPillarBenefit;
const Effort = @import("effort.zig").Effort;
const RecommendationGoal = @import("recommendation_goal.zig").RecommendationGoal;
const ImpactCategory = @import("impact_category.zig").ImpactCategory;
const Insight = @import("insight.zig").Insight;
const Pillar = @import("pillar.zig").Pillar;
const Priority = @import("priority.zig").Priority;
const AgentRecommendationRemediation = @import("agent_recommendation_remediation.zig").AgentRecommendationRemediation;
const RemediationSummary = @import("remediation_summary.zig").RemediationSummary;
const Roi = @import("roi.zig").Roi;
const RecommendationSource = @import("recommendation_source.zig").RecommendationSource;
const RecommendationState = @import("recommendation_state.zig").RecommendationState;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const Tag = @import("tag.zig").Tag;
const TradeOff = @import("trade_off.zig").TradeOff;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;

pub const GetAgentRecommendationInput = struct {
    /// The Amazon Resource Name (ARN) of the recommendation to retrieve.
    recommendation_arn: []const u8,

    /// Optional filter on remediation type.
    remediation_type: ?RemediationType = null,

    pub const json_field_names = .{
        .recommendation_arn = "recommendationArn",
        .remediation_type = "remediationType",
    };
};

pub const GetAgentRecommendationOutput = struct {
    /// The applications that the recommendation targets.
    applications: ?[]const []const u8 = null,

    /// The Amazon Web Services services that the recommendation applies to.
    aws_services: ?[]const []const u8 = null,

    /// The business units that own the affected resources.
    business_units: ?[]const []const u8 = null,

    /// The timestamp when the recommendation was created.
    created_at: i64,

    /// The identifier of the user or system that created this recommendation.
    created_by: []const u8,

    /// Cross-pillar benefits of acting on the recommendation.
    cross_pillar_benefits: ?[]const CrossPillarBenefit = null,

    /// A description of the recommendation.
    description: []const u8,

    /// The effort required to implement the recommendation.
    effort: Effort,

    /// The identifier of the generation process that produced this recommendation.
    generation_id: ?[]const u8 = null,

    /// Goals that this recommendation targets.
    goals: ?[]const RecommendationGoal = null,

    /// Highlights describing what was detected.
    highlights: ?[]const []const u8 = null,

    /// The severity of the recommendation's impact.
    impact: ImpactCategory,

    /// Detailed impact information for the recommendation.
    impact_details: ?[]const []const u8 = null,

    /// A list of insights about the recommendation.
    insights: ?[]const Insight = null,

    /// The timestamp when the recommendation was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this recommendation.
    last_modified_by: ?[]const u8 = null,

    /// The number of Amazon Web Services resources this recommendation affects.
    number_of_resources: ?i32 = null,

    /// The Well-Architected Tool Framework pillar that the recommendation
    /// addresses.
    pillar: Pillar,

    /// The priority of the recommendation.
    priority: Priority,

    /// The Amazon Resource Name (ARN) of the associated profile.
    profile_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the recommendation.
    recommendation_arn: []const u8,

    /// A list of remediations for the recommendation.
    remediations: ?[]const AgentRecommendationRemediation = null,

    /// A high-level summary of the recommended remediation.
    remediation_summary: ?RemediationSummary = null,

    /// The return on investment estimate for the recommendation.
    roi: ?Roi = null,

    /// Sources that generated this recommendation.
    sources: ?[]const RecommendationSource = null,

    /// The current state of the recommendation.
    state: RecommendationState,

    /// The current status of the recommendation.
    status: RecommendationStatus,

    /// A set of key-value pairs associated with the recommendation, used for cost
    /// allocation and access control.
    tags: ?[]const Tag = null,

    /// The title of the recommendation.
    title: []const u8,

    /// Trade-offs of acting on the recommendation.
    trade_offs: ?[]const TradeOff = null,

    /// The type of the recommendation.
    @"type": RecommendationType,

    /// The free-text reason associated with the recommendation's most recent status
    /// update.
    update_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .applications = "applications",
        .aws_services = "awsServices",
        .business_units = "businessUnits",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .cross_pillar_benefits = "crossPillarBenefits",
        .description = "description",
        .effort = "effort",
        .generation_id = "generationId",
        .goals = "goals",
        .highlights = "highlights",
        .impact = "impact",
        .impact_details = "impactDetails",
        .insights = "insights",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .number_of_resources = "numberOfResources",
        .pillar = "pillar",
        .priority = "priority",
        .profile_arn = "profileArn",
        .recommendation_arn = "recommendationArn",
        .remediations = "remediations",
        .remediation_summary = "remediationSummary",
        .roi = "roi",
        .sources = "sources",
        .state = "state",
        .status = "status",
        .tags = "tags",
        .title = "title",
        .trade_offs = "tradeOffs",
        .@"type" = "type",
        .update_reason = "updateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentRecommendationInput, options: CallOptions) !GetAgentRecommendationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/agent-recommendations/");
    try path_buf.appendSlice(allocator, input.recommendation_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.remediation_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "remediationType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentRecommendationOutput {
    const result: GetAgentRecommendationOutput = try aws.json.parseJsonObject(
        GetAgentRecommendationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
