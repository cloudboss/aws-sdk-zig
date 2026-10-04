const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociationType = @import("association_type.zig").AssociationType;
const SupportPlan = @import("support_plan.zig").SupportPlan;
const ResaleAccountModel = @import("resale_account_model.zig").ResaleAccountModel;
const Sector = @import("sector.zig").Sector;
const Tag = @import("tag.zig").Tag;
const CreateRelationshipDetail = @import("create_relationship_detail.zig").CreateRelationshipDetail;

pub const CreateRelationshipInput = struct {
    /// The AWS account ID to associate in this relationship.
    associated_account_id: []const u8,

    /// The type of association for the relationship (e.g., reseller, distributor).
    association_type: AssociationType,

    /// The catalog identifier for the relationship.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A human-readable name for the relationship.
    display_name: []const u8,

    /// The identifier of the program management account for this relationship.
    program_management_account_identifier: []const u8,

    /// The support plan requested for this relationship.
    requested_support_plan: ?SupportPlan = null,

    /// The resale account model for the relationship.
    resale_account_model: ?ResaleAccountModel = null,

    /// The business sector for the relationship.
    sector: Sector,

    /// Key-value pairs to associate with the relationship.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .associated_account_id = "associatedAccountId",
        .association_type = "associationType",
        .catalog = "catalog",
        .client_token = "clientToken",
        .display_name = "displayName",
        .program_management_account_identifier = "programManagementAccountIdentifier",
        .requested_support_plan = "requestedSupportPlan",
        .resale_account_model = "resaleAccountModel",
        .sector = "sector",
        .tags = "tags",
    };
};

pub const CreateRelationshipOutput = struct {
    /// Details of the created relationship.
    relationship_detail: ?CreateRelationshipDetail = null,

    pub const json_field_names = .{
        .relationship_detail = "relationshipDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRelationshipInput, options: CallOptions) !CreateRelationshipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRelationshipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-channel", "PartnerCentral Channel", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralChannel.CreateRelationship");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRelationshipOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRelationshipOutput, body, allocator);
}
