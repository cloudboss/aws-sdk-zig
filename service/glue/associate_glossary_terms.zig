const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateGlossaryTermsInput = struct {
    /// The unique identifier of the asset to associate glossary terms with.
    asset_identifier: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The list of glossary term identifiers to associate with the asset.
    glossary_term_identifiers: []const []const u8,

    /// The identifier of the item within the iterable form. Required when
    /// `iterableFormName` is specified.
    item_identifier: ?[]const u8 = null,

    /// The name of the iterable form. When specified along with `itemIdentifier`,
    /// the glossary terms are associated with an item within the iterable form
    /// rather than the asset itself.
    iterable_form_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_identifier = "AssetIdentifier",
        .client_token = "ClientToken",
        .glossary_term_identifiers = "GlossaryTermIdentifiers",
        .item_identifier = "ItemIdentifier",
        .iterable_form_name = "IterableFormName",
    };
};

pub const AssociateGlossaryTermsOutput = struct {
    /// The unique identifier of the asset.
    asset_identifier: ?[]const u8 = null,

    /// The glossary terms now associated with the asset.
    glossary_terms: ?[]const []const u8 = null,

    /// The identifier of the item within the iterable form, if applicable.
    item_identifier: ?[]const u8 = null,

    /// The name of the iterable form, if the association targets an item.
    iterable_form_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_identifier = "AssetIdentifier",
        .glossary_terms = "GlossaryTerms",
        .item_identifier = "ItemIdentifier",
        .iterable_form_name = "IterableFormName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateGlossaryTermsInput, options: CallOptions) !AssociateGlossaryTermsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateGlossaryTermsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.AssociateGlossaryTerms");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateGlossaryTermsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateGlossaryTermsOutput, body, allocator);
}
