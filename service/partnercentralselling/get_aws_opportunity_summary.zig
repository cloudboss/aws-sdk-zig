const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AwsOpportunityCustomer = @import("aws_opportunity_customer.zig").AwsOpportunityCustomer;
const AwsOpportunityInsights = @import("aws_opportunity_insights.zig").AwsOpportunityInsights;
const SalesInvolvementType = @import("sales_involvement_type.zig").SalesInvolvementType;
const InvolvementTypeChangeReason = @import("involvement_type_change_reason.zig").InvolvementTypeChangeReason;
const AwsOpportunityLifeCycle = @import("aws_opportunity_life_cycle.zig").AwsOpportunityLifeCycle;
const AwsTeamMember = @import("aws_team_member.zig").AwsTeamMember;
const OpportunityOrigin = @import("opportunity_origin.zig").OpportunityOrigin;
const AwsOpportunityProject = @import("aws_opportunity_project.zig").AwsOpportunityProject;
const AwsOpportunityRelatedEntities = @import("aws_opportunity_related_entities.zig").AwsOpportunityRelatedEntities;
const Visibility = @import("visibility.zig").Visibility;

pub const GetAwsOpportunitySummaryInput = struct {
    /// Specifies the catalog in which the AWS Opportunity is located. Accepted
    /// values include `AWS` for production opportunities or `Sandbox` for testing
    /// purposes. The catalog determines which environment the opportunity data is
    /// pulled from.
    catalog: []const u8,

    /// The unique identifier for the related partner opportunity. Use this field to
    /// correlate an AWS opportunity with its corresponding partner opportunity.
    related_opportunity_identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .related_opportunity_identifier = "RelatedOpportunityIdentifier",
    };
};

pub const GetAwsOpportunitySummaryOutput = struct {
    /// Specifies the catalog in which the AWS Opportunity exists. This is the
    /// environment (e.g., `AWS` or `Sandbox`) where the opportunity is being
    /// managed.
    catalog: []const u8,

    /// Provides details about the customer associated with the AWS Opportunity,
    /// including account information, industry, and other customer data. These
    /// details help partners understand the business context of the opportunity.
    customer: ?AwsOpportunityCustomer = null,

    /// Provides insights into the AWS Opportunity, including engagement score and
    /// recommended actions that AWS suggests for the partner.
    insights: ?AwsOpportunityInsights = null,

    /// Specifies the type of involvement AWS has in the opportunity, such as direct
    /// cosell or advisory support. This field helps partners understand the role
    /// AWS plays in advancing the opportunity.
    involvement_type: ?SalesInvolvementType = null,

    /// Provides a reason for any changes in the involvement type of AWS in the
    /// opportunity. This field is used to track why the level of AWS engagement has
    /// changed from `For Visibility Only` to `Co-sell` offering transparency into
    /// the partnership dynamics.
    involvement_type_change_reason: ?InvolvementTypeChangeReason = null,

    /// Contains lifecycle information for the AWS Opportunity, including review
    /// status, stage, and target close date. This field is crucial for partners to
    /// monitor the progression of the opportunity.
    life_cycle: ?AwsOpportunityLifeCycle = null,

    /// Details the AWS opportunity team, including members involved. This
    /// information helps partners know who from AWS is engaged and what their role
    /// is.
    opportunity_team: ?[]const AwsTeamMember = null,

    /// Specifies whether the AWS Opportunity originated from AWS or the partner.
    /// This helps distinguish between opportunities that were sourced by AWS and
    /// those referred by the partner.
    origin: ?OpportunityOrigin = null,

    /// Provides details about the project associated with the AWS Opportunity,
    /// including the customer’s business problem, expected outcomes, and project
    /// scope. This information is crucial for understanding the broader context of
    /// the opportunity.
    project: ?AwsOpportunityProject = null,

    /// Lists related entity identifiers, such as AWS products or partner solutions,
    /// associated with the AWS Opportunity. These identifiers provide additional
    /// context and help partners understand which AWS services are involved.
    related_entity_ids: ?AwsOpportunityRelatedEntities = null,

    /// Provides the unique identifier of the related partner opportunity, allowing
    /// partners to link the AWS Opportunity to their corresponding opportunity in
    /// their CRM system.
    related_opportunity_id: ?[]const u8 = null,

    /// Defines the visibility level for the AWS Opportunity. Use `Full` visibility
    /// for most cases, while `Limited` visibility is reserved for special programs
    /// or sensitive opportunities.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .customer = "Customer",
        .insights = "Insights",
        .involvement_type = "InvolvementType",
        .involvement_type_change_reason = "InvolvementTypeChangeReason",
        .life_cycle = "LifeCycle",
        .opportunity_team = "OpportunityTeam",
        .origin = "Origin",
        .project = "Project",
        .related_entity_ids = "RelatedEntityIds",
        .related_opportunity_id = "RelatedOpportunityId",
        .visibility = "Visibility",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAwsOpportunitySummaryInput, options: CallOptions) !GetAwsOpportunitySummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentral");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAwsOpportunitySummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.GetAwsOpportunitySummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAwsOpportunitySummaryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAwsOpportunitySummaryOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
