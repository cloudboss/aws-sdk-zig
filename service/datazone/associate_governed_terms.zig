const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GovernedEntityType = @import("governed_entity_type.zig").GovernedEntityType;

pub const AssociateGovernedTermsInput = struct {
    /// The ID of the domain where governed terms are to be associated with an
    /// asset.
    domain_identifier: []const u8,

    /// The ID of the asset with which you want to associate a governed term.
    entity_identifier: []const u8,

    /// The type of the asset with which you want to associate a governed term.
    entity_type: GovernedEntityType,

    /// The glossary terms in a restricted glossary.
    governed_glossary_terms: []const []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .entity_identifier = "entityIdentifier",
        .entity_type = "entityType",
        .governed_glossary_terms = "governedGlossaryTerms",
    };
};

pub const AssociateGovernedTermsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateGovernedTermsInput, options: CallOptions) !AssociateGovernedTermsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateGovernedTermsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/entities/");
    try path_buf.appendSlice(allocator, input.entity_type);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.entity_identifier);
    try path_buf.appendSlice(allocator, "/associate-governed-terms");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"governedGlossaryTerms\":");
    try aws.json.writeValue(@TypeOf(input.governed_glossary_terms), input.governed_glossary_terms, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateGovernedTermsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateGovernedTermsOutput = .{};

    return result;
}
