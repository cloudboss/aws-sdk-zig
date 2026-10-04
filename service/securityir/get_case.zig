const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaseAttachmentAttributes = @import("case_attachment_attributes.zig").CaseAttachmentAttributes;
const CaseMetadataEntry = @import("case_metadata_entry.zig").CaseMetadataEntry;
const CaseStatus = @import("case_status.zig").CaseStatus;
const ClosureCode = @import("closure_code.zig").ClosureCode;
const EngagementType = @import("engagement_type.zig").EngagementType;
const ImpactedAwsRegion = @import("impacted_aws_region.zig").ImpactedAwsRegion;
const PendingAction = @import("pending_action.zig").PendingAction;
const ResolverType = @import("resolver_type.zig").ResolverType;
const ThreatActorIp = @import("threat_actor_ip.zig").ThreatActorIp;
const Watcher = @import("watcher.zig").Watcher;

pub const GetCaseInput = struct {
    /// Required element for GetCase to identify the requested case ID.
    case_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub const GetCaseOutput = struct {
    /// Response element for GetCase that provides the actual incident start date as
    /// identified by data analysis during the investigation.
    actual_incident_start_date: ?i64 = null,

    /// Response element for GetCase that provides the case ARN
    case_arn: ?[]const u8 = null,

    /// Response element for GetCase that provides a list of current case
    /// attachments.
    case_attachments: ?[]const CaseAttachmentAttributes = null,

    /// Case response metadata
    case_metadata: ?[]const CaseMetadataEntry = null,

    /// Response element for GetCase that provides the case status. Options for
    /// statuses include `Submitted | Detection and Analysis | Eradication,
    /// Containment and Recovery | Post-Incident Activities | Closed `
    case_status: ?CaseStatus = null,

    /// Response element for GetCase that provides the date a specified case was
    /// closed.
    closed_date: ?i64 = null,

    /// Response element for GetCase that provides the summary code for why a case
    /// was closed.
    closure_code: ?ClosureCode = null,

    /// Response element for GetCase that provides the date the case was created.
    created_date: ?i64 = null,

    /// Response element for GetCase that provides contents of the case description.
    description: ?[]const u8 = null,

    /// Response element for GetCase that provides the engagement type. Options for
    /// engagement type include `Active Security Event | Investigations`
    engagement_type: ?EngagementType = null,

    /// Response element for GetCase that provides a list of impacted accounts.
    impacted_accounts: ?[]const []const u8 = null,

    /// Response element for GetCase that provides the impacted regions.
    impacted_aws_regions: ?[]const ImpactedAwsRegion = null,

    /// Response element for GetCase that provides a list of impacted services.
    impacted_services: ?[]const []const u8 = null,

    /// Response element for GetCase that provides the date a case was last
    /// modified.
    last_updated_date: ?i64 = null,

    /// Response element for GetCase that identifies the case is waiting on customer
    /// input.
    pending_action: ?PendingAction = null,

    /// Response element for GetCase that provides the customer provided incident
    /// start date.
    reported_incident_start_date: ?i64 = null,

    /// Response element for GetCase that provides the current resolver types.
    resolver_type: ?ResolverType = null,

    /// Response element for GetCase that provides a list of suspicious IP addresses
    /// associated with unauthorized activity.
    threat_actor_ip_addresses: ?[]const ThreatActorIp = null,

    /// Response element for GetCase that provides the case title.
    title: ?[]const u8 = null,

    /// Response element for GetCase that provides a list of Watchers added to the
    /// case.
    watchers: ?[]const Watcher = null,

    pub const json_field_names = .{
        .actual_incident_start_date = "actualIncidentStartDate",
        .case_arn = "caseArn",
        .case_attachments = "caseAttachments",
        .case_metadata = "caseMetadata",
        .case_status = "caseStatus",
        .closed_date = "closedDate",
        .closure_code = "closureCode",
        .created_date = "createdDate",
        .description = "description",
        .engagement_type = "engagementType",
        .impacted_accounts = "impactedAccounts",
        .impacted_aws_regions = "impactedAwsRegions",
        .impacted_services = "impactedServices",
        .last_updated_date = "lastUpdatedDate",
        .pending_action = "pendingAction",
        .reported_incident_start_date = "reportedIncidentStartDate",
        .resolver_type = "resolverType",
        .threat_actor_ip_addresses = "threatActorIpAddresses",
        .title = "title",
        .watchers = "watchers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCaseInput, options: CallOptions) !GetCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/get-case");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCaseOutput {
    const result: GetCaseOutput = try aws.json.parseJsonObject(
        GetCaseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
