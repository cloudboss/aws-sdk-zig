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
const OpportunityOrigin = @import("opportunity_origin.zig").OpportunityOrigin;
const PrimaryNeedFromAws = @import("primary_need_from_aws.zig").PrimaryNeedFromAws;
const Project = @import("project.zig").Project;
const SoftwareRevenue = @import("software_revenue.zig").SoftwareRevenue;
const Tag = @import("tag.zig").Tag;

pub const CreateOpportunityInput = struct {
    /// Specifies the catalog associated with the request. This field takes a string
    /// value from a predefined list: `AWS` or `Sandbox`. The catalog determines
    /// which environment the opportunity is created in. Use `AWS` to create
    /// opportunities in the Amazon Web Services catalog, and `Sandbox` for testing
    /// in secure, isolated environments.
    catalog: []const u8,

    /// Required to be unique, and should be unchanging, it can be randomly
    /// generated or a meaningful string.
    ///
    /// Default: None
    ///
    /// Best practice: To help ensure uniqueness and avoid conflicts, use a
    /// Universally Unique Identifier (UUID) as the `ClientToken`. You can use
    /// standard libraries from most programming languages to generate this. If you
    /// use the same client token, the API returns the following error: "Conflicting
    /// client token submitted for a new request body."
    client_token: []const u8,

    /// Specifies customer details associated with the `Opportunity`.
    customer: ?Customer = null,

    /// An object that contains lifecycle details for the `Opportunity`.
    life_cycle: ?LifeCycle = null,

    /// This object contains marketing details and is optional for an opportunity.
    marketing: ?Marketing = null,

    /// Indicates whether the `Opportunity` pertains to a national security project.
    /// This field must be set to `true` only when the customer's industry is
    /// *Government*. Additional privacy and security measures apply during the
    /// review and management process for opportunities marked as
    /// `NationalSecurity`.
    national_security: ?NationalSecurity = null,

    /// Represents the internal team handling the opportunity. Specify collaborating
    /// members of this opportunity who are within the partner's organization.
    opportunity_team: ?[]const Contact = null,

    /// Specifies the opportunity type as a renewal, new, or expansion.
    ///
    /// Opportunity types:
    ///
    /// * New opportunity: Represents a new business opportunity with a potential
    ///   customer that's not previously engaged with your solutions or services.
    /// * Renewal opportunity: Represents an opportunity to renew an existing
    ///   contract or subscription with a current customer, ensuring continuity of
    ///   service.
    /// * Expansion opportunity: Represents an opportunity to expand the scope of an
    ///   existing contract or subscription, either by adding new services or
    ///   increasing the volume of existing services for a current customer.
    opportunity_type: ?OpportunityType = null,

    /// Specifies the origin of the opportunity, indicating if it was sourced from
    /// Amazon Web Services or the partner. For all opportunities created with
    /// `Catalog: AWS`, this field must only be `Partner Referral`. However, when
    /// using `Catalog: Sandbox`, you can set this field to `AWS Referral` to
    /// simulate Amazon Web Services referral creation. This allows Amazon Web
    /// Services-originated flows testing in the sandbox catalog.
    origin: ?OpportunityOrigin = null,

    /// Specifies the opportunity's unique identifier in the partner's CRM system.
    /// This value is essential to track and reconcile because it's included in the
    /// outbound payload to the partner.
    ///
    /// This field allows partners to link an opportunity to their CRM, which helps
    /// to ensure seamless integration and accurate synchronization between the
    /// Partner Central API and the partner's internal systems.
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

    /// An object that contains project details for the `Opportunity`.
    project: ?Project = null,

    /// Specifies details of a customer's procurement terms. This is required only
    /// for partners in eligible programs.
    software_revenue: ?SoftwareRevenue = null,

    /// A map of the key-value pairs of the tag or tags to assign.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .customer = "Customer",
        .life_cycle = "LifeCycle",
        .marketing = "Marketing",
        .national_security = "NationalSecurity",
        .opportunity_team = "OpportunityTeam",
        .opportunity_type = "OpportunityType",
        .origin = "Origin",
        .partner_opportunity_identifier = "PartnerOpportunityIdentifier",
        .primary_needs_from_aws = "PrimaryNeedsFromAws",
        .project = "Project",
        .software_revenue = "SoftwareRevenue",
        .tags = "Tags",
    };
};

pub const CreateOpportunityOutput = struct {
    /// Read-only, system-generated `Opportunity` unique identifier. Amazon Web
    /// Services creates this identifier, and it's used for all subsequent
    /// opportunity actions, such as updates, associations, and submissions. It
    /// helps to ensure that each opportunity is accurately tracked and managed.
    id: []const u8,

    /// `DateTime` when the opportunity was last modified. When the `Opportunity` is
    /// created, its value is `CreatedDate`.
    last_modified_date: ?i64 = null,

    /// Specifies the opportunity's unique identifier in the partner's CRM system.
    /// This value is essential to track and reconcile because it's included in the
    /// outbound payload sent back to the partner.
    partner_opportunity_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .last_modified_date = "LastModifiedDate",
        .partner_opportunity_identifier = "PartnerOpportunityIdentifier",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOpportunityInput, options: Options) !CreateOpportunityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOpportunityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.CreateOpportunity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOpportunityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateOpportunityOutput, body, allocator);
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
