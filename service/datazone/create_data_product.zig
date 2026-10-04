const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FormInput = @import("form_input.zig").FormInput;
const DataProductItem = @import("data_product_item.zig").DataProductItem;
const FormOutput = @import("form_output.zig").FormOutput;
const DataProductStatus = @import("data_product_status.zig").DataProductStatus;

pub const CreateDataProductInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the data product.
    description: ?[]const u8 = null,

    /// The ID of the domain where the data product is created.
    domain_identifier: []const u8,

    /// The metadata forms of the data product.
    forms_input: ?[]const FormInput = null,

    /// The glossary terms of the data product.
    glossary_terms: ?[]const []const u8 = null,

    /// The data assets of the data product.
    items: ?[]const DataProductItem = null,

    /// The name of the data product.
    name: []const u8,

    /// The ID of the owning project of the data product.
    owning_project_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .forms_input = "formsInput",
        .glossary_terms = "glossaryTerms",
        .items = "items",
        .name = "name",
        .owning_project_identifier = "owningProjectIdentifier",
    };
};

pub const CreateDataProductOutput = struct {
    /// The timestamp at which the data product was created.
    created_at: ?i64 = null,

    /// The user who created the data product.
    created_by: ?[]const u8 = null,

    /// The description of the data product.
    description: ?[]const u8 = null,

    /// The ID of the domain where the data product lives.
    domain_id: []const u8,

    /// The timestamp at which the first revision of the data product was created.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataProductInput, options: CallOptions) !CreateDataProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataProductInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/data-products");
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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.forms_input) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"formsInput\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.glossary_terms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"glossaryTerms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.items) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"items\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataProductOutput {
    const result: CreateDataProductOutput = try aws.json.parseJsonObject(
        CreateDataProductOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
