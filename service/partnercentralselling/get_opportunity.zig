const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Customer = @import("customer.zig").Customer;
const LifeCycle = @import("life_cycle.zig").LifeCycle;
const Marketing = @import("marketing.zig").Marketing;
const NationalSecurity = @import("national_security.zig").NationalSecurity;
const Contact = @import("contact.zig").Contact;
const OpportunityType = @import("opportunity_type.zig").OpportunityType;
const PrimaryNeedFromAws = @import("primary_need_from_aws.zig").PrimaryNeedFromAws;
const Project = @import("project.zig").Project;
const RelatedEntityIdentifiers = @import("related_entity_identifiers.zig").RelatedEntityIdentifiers;
const SoftwareRevenue = @import("software_revenue.zig").SoftwareRevenue;

pub const GetOpportunityInput = struct {
    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunity is fetched from. Use `AWS` to retrieve
    /// opportunities in the Amazon Web Services catalog, and `Sandbox` to retrieve
    /// opportunities in a secure, isolated testing environment.
    catalog: []const u8,

    /// Read-only, system generated `Opportunity` unique identifier.
    identifier: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .identifier = "Identifier",
    };
};

pub const GetOpportunityOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the opportunity.
    arn: ?[]const u8 = null,

    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunity information is retrieved from. Use `AWS`
    /// to retrieve opportunities in the Amazon Web Services catalog, and `Sandbox`
    /// to retrieve opportunities in a secure and isolated testing environment.
    catalog: []const u8,

    /// `DateTime` when the `Opportunity` was last created.
    created_date: i64,

    /// Specifies details of the customer associated with the `Opportunity`.
    customer: ?Customer = null,

    /// Read-only, system generated `Opportunity` unique identifier.
    id: []const u8,

    /// `DateTime` when the opportunity was last modified.
    last_modified_date: i64,

    /// An object that contains lifecycle details for the `Opportunity`.
    life_cycle: ?LifeCycle = null,

    /// An object that contains marketing details for the `Opportunity`.
    marketing: ?Marketing = null,

    /// Indicates whether the `Opportunity` pertains to a national security project.
    /// This field must be set to `true` only when the customer's industry is
    /// *Government*. Additional privacy and security measures apply during the
    /// review and management process for opportunities marked as
    /// `NationalSecurity`.
    national_security: ?NationalSecurity = null,

    /// Represents the internal team handling the opportunity. Specify the members
    /// involved in collaborating on this opportunity within the partner's
    /// organization.
    opportunity_team: ?[]const Contact = null,

    /// Specifies the opportunity type as renewal, new, or expansion.
    ///
    /// Opportunity types:
    ///
    /// * New opportunity: Represents a new business opportunity with a potential
    ///   customer that's not previously engaged with your solutions or services.
    /// * Renewal opportunity: Represents an opportunity to renew an existing
    ///   contract or subscription with a current customer, which helps to ensure
    ///   service continuity.
    /// * Expansion opportunity: Represents an opportunity to expand the scope of a
    ///   customer's contract or subscription, either by adding new services or
    ///   increasing the volume of existing services.
    opportunity_type: ?OpportunityType = null,

    /// Specifies the opportunity's unique identifier in the partner's CRM system.
    /// This value is essential to track and reconcile because it's included in the
    /// outbound payload sent back to the partner.
    partner_opportunity_identifier: ?[]const u8 = null,

    /// Identifies the type of support the partner needs from Amazon Web Services.
    ///
    /// Valid values:
    ///
    /// * Cosell—Architectural Validation: Confirmation from Amazon Web Services
    ///   that the partner's proposed solution architecture is aligned with Amazon
    ///   Web Services best practices and poses minimal architectural risks.
    /// * Cosell—Business Presentation: Request Amazon Web Services seller's
    ///   participation in a joint customer presentation.
    /// * Cosell—Competitive Information: Access to Amazon Web Services competitive
    ///   resources and support for the partner's proposed solution.
    /// * Cosell—Pricing Assistance: Connect with an Amazon Web Services seller for
    ///   support situations where a partner may be receiving an upfront discount on
    ///   a service (for example: EDP deals).
    /// * Cosell—Technical Consultation: Connect with an Amazon Web Services
    ///   Solutions Architect to address the partner's questions about the proposed
    ///   solution.
    /// * Cosell—Total Cost of Ownership Evaluation: Assistance with quoting
    ///   different cost savings of proposed solutions on Amazon Web Services versus
    ///   on-premises or a traditional hosting environment.
    /// * Cosell—Deal Support: Request Amazon Web Services seller's support to
    ///   progress the opportunity (for example: joint customer call, strategic
    ///   positioning).
    /// * Cosell—Support for Public Tender/RFx: Opportunity related to the public
    ///   sector where the partner needs Amazon Web Services RFx support.
    primary_needs_from_aws: ?[]const PrimaryNeedFromAws = null,

    /// An object that contains project details summary for the `Opportunity`.
    project: ?Project = null,

    /// Provides information about the associations of other entities with the
    /// opportunity. These entities include identifiers for `AWSProducts`, `Partner
    /// Solutions`, and `AWSMarketplaceOffers`.
    related_entity_identifiers: ?RelatedEntityIdentifiers = null,

    /// Specifies details of a customer's procurement terms. Required only for
    /// partners in eligible programs.
    software_revenue: ?SoftwareRevenue = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .created_date = "CreatedDate",
        .customer = "Customer",
        .id = "Id",
        .last_modified_date = "LastModifiedDate",
        .life_cycle = "LifeCycle",
        .marketing = "Marketing",
        .national_security = "NationalSecurity",
        .opportunity_team = "OpportunityTeam",
        .opportunity_type = "OpportunityType",
        .partner_opportunity_identifier = "PartnerOpportunityIdentifier",
        .primary_needs_from_aws = "PrimaryNeedsFromAws",
        .project = "Project",
        .related_entity_identifiers = "RelatedEntityIdentifiers",
        .software_revenue = "SoftwareRevenue",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOpportunityInput, options: Options) !GetOpportunityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOpportunityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.GetOpportunity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOpportunityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetOpportunityOutput, body, allocator);
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
