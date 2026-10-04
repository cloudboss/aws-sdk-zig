const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlossaryTermStatus = @import("glossary_term_status.zig").GlossaryTermStatus;
const TermRelations = @import("term_relations.zig").TermRelations;
const GlossaryUsageRestriction = @import("glossary_usage_restriction.zig").GlossaryUsageRestriction;

pub const GetGlossaryTermInput = struct {
    /// The ID of the Amazon DataZone domain in which this business glossary term
    /// exists.
    domain_identifier: []const u8,

    /// The ID of the business glossary term.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetGlossaryTermOutput = struct {
    /// The timestamp of when the business glossary term was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the business glossary.
    created_by: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this business glossary term
    /// exists.
    domain_id: []const u8,

    /// The ID of the business glossary to which this term belongs.
    glossary_id: []const u8,

    /// The ID of the business glossary term.
    id: []const u8,

    /// The long description of the business glossary term.
    long_description: ?[]const u8 = null,

    /// The name of the business glossary term.
    name: []const u8,

    /// The short decription of the business glossary term.
    short_description: ?[]const u8 = null,

    /// The status of the business glossary term.
    status: GlossaryTermStatus,

    /// The relations of the business glossary term.
    term_relations: ?TermRelations = null,

    /// The timestamp of when the business glossary term was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user who updated the business glossary term.
    updated_by: ?[]const u8 = null,

    /// The usage restriction of a term within a restricted glossary.
    usage_restrictions: ?[]const GlossaryUsageRestriction = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .glossary_id = "glossaryId",
        .id = "id",
        .long_description = "longDescription",
        .name = "name",
        .short_description = "shortDescription",
        .status = "status",
        .term_relations = "termRelations",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .usage_restrictions = "usageRestrictions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGlossaryTermInput, options: CallOptions) !GetGlossaryTermOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGlossaryTermInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/glossary-terms/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGlossaryTermOutput {
    const result: GetGlossaryTermOutput = try aws.json.parseJsonObject(
        GetGlossaryTermOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
