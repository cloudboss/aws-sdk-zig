const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlossaryTermStatus = @import("glossary_term_status.zig").GlossaryTermStatus;
const TermRelations = @import("term_relations.zig").TermRelations;
const GlossaryUsageRestriction = @import("glossary_usage_restriction.zig").GlossaryUsageRestriction;

pub const CreateGlossaryTermInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this business glossary term is
    /// created.
    domain_identifier: []const u8,

    /// The ID of the business glossary in which this term is created.
    glossary_identifier: []const u8,

    /// The long description of this business glossary term.
    long_description: ?[]const u8 = null,

    /// The name of this business glossary term.
    name: []const u8,

    /// The short description of this business glossary term.
    short_description: ?[]const u8 = null,

    /// The status of this business glossary term.
    status: ?GlossaryTermStatus = null,

    /// The term relations of this business glossary term.
    term_relations: ?TermRelations = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .glossary_identifier = "glossaryIdentifier",
        .long_description = "longDescription",
        .name = "name",
        .short_description = "shortDescription",
        .status = "status",
        .term_relations = "termRelations",
    };
};

pub const CreateGlossaryTermOutput = struct {
    /// The ID of the Amazon DataZone domain in which this business glossary term is
    /// created.
    domain_id: []const u8,

    /// The ID of the business glossary in which this term is created.
    glossary_id: []const u8,

    /// The ID of this business glossary term.
    id: []const u8,

    /// The long description of this business glossary term.
    long_description: ?[]const u8 = null,

    /// The name of this business glossary term.
    name: []const u8,

    /// The short description of this business glossary term.
    short_description: ?[]const u8 = null,

    /// The status of this business glossary term.
    status: GlossaryTermStatus,

    /// The term relations of this business glossary term.
    term_relations: ?TermRelations = null,

    /// The usage restriction of the restricted glossary.
    usage_restrictions: ?[]const GlossaryUsageRestriction = null,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .glossary_id = "glossaryId",
        .id = "id",
        .long_description = "longDescription",
        .name = "name",
        .short_description = "shortDescription",
        .status = "status",
        .term_relations = "termRelations",
        .usage_restrictions = "usageRestrictions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGlossaryTermInput, options: CallOptions) !CreateGlossaryTermOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGlossaryTermInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/glossary-terms");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"glossaryIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.glossary_identifier), input.glossary_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.long_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"longDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.short_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"shortDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.term_relations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"termRelations\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGlossaryTermOutput {
    const result: CreateGlossaryTermOutput = try aws.json.parseJsonObject(
        CreateGlossaryTermOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
