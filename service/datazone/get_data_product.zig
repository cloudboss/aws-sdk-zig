const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FormOutput = @import("form_output.zig").FormOutput;
const DataProductItem = @import("data_product_item.zig").DataProductItem;
const DataProductStatus = @import("data_product_status.zig").DataProductStatus;

pub const GetDataProductInput = struct {
    /// The ID of the domain where the data product lives.
    domain_identifier: []const u8,

    /// The ID of the data product.
    identifier: []const u8,

    /// The revision of the data product.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .revision = "revision",
    };
};

pub const GetDataProductOutput = struct {
    /// The timestamp at which the data product is created.
    created_at: ?i64 = null,

    /// The user who created the data product.
    created_by: ?[]const u8 = null,

    /// The description of the data product.
    description: ?[]const u8 = null,

    /// The ID of the domain where the data product lives.
    domain_id: []const u8,

    /// The timestamp at which the first revision of the data product is created.
    first_revision_created_at: ?i64 = null,

    /// The user who created the first revision of the data product.
    first_revision_created_by: ?[]const u8 = null,

    /// The metadata forms of the data product.
    forms_output: ?[]const FormOutput = null,

    /// The glossary terms of the data product.
    glossary_terms: ?[]const []const u8 = null,

    /// The ID of the data product.
    id: []const u8,

    /// The data assets of the data product.
    items: ?[]const DataProductItem = null,

    /// The name of the data product.
    name: []const u8,

    /// The ID of the owning project of the data product.
    owning_project_id: []const u8,

    /// The revision of the data product.
    revision: []const u8,

    /// The status of the data product.
    status: ?DataProductStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .first_revision_created_at = "firstRevisionCreatedAt",
        .first_revision_created_by = "firstRevisionCreatedBy",
        .forms_output = "formsOutput",
        .glossary_terms = "glossaryTerms",
        .id = "id",
        .items = "items",
        .name = "name",
        .owning_project_id = "owningProjectId",
        .revision = "revision",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataProductInput, options: CallOptions) !GetDataProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataProductInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-products/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "revision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataProductOutput {
    const result: GetDataProductOutput = try aws.json.parseJsonObject(
        GetDataProductOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
