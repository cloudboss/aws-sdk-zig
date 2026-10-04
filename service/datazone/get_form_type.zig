const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Import = @import("import.zig").Import;
const Model = @import("model.zig").Model;
const FormTypeStatus = @import("form_type_status.zig").FormTypeStatus;

pub const GetFormTypeInput = struct {
    /// The ID of the Amazon DataZone domain in which this metadata form type
    /// exists.
    domain_identifier: []const u8,

    /// The ID of the metadata form type.
    form_type_identifier: []const u8,

    /// The revision of this metadata form type.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .form_type_identifier = "formTypeIdentifier",
        .revision = "revision",
    };
};

pub const GetFormTypeOutput = struct {
    /// The timestamp of when this metadata form type was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created this metadata form type.
    created_by: ?[]const u8 = null,

    /// The description of the metadata form type.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this metadata form type
    /// exists.
    domain_id: []const u8,

    /// The imports of the metadata form type.
    imports: ?[]const Import = null,

    /// The model of the metadata form type.
    model: ?Model = null,

    /// The name of the metadata form type.
    name: []const u8,

    /// The ID of the Amazon DataZone domain in which the metadata form type was
    /// originally created.
    origin_domain_id: ?[]const u8 = null,

    /// The ID of the project in which this metadata form type was originally
    /// created.
    origin_project_id: ?[]const u8 = null,

    /// The ID of the project that owns this metadata form type.
    owning_project_id: ?[]const u8 = null,

    /// The revision of the metadata form type.
    revision: []const u8,

    /// The status of the metadata form type.
    status: ?FormTypeStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .imports = "imports",
        .model = "model",
        .name = "name",
        .origin_domain_id = "originDomainId",
        .origin_project_id = "originProjectId",
        .owning_project_id = "owningProjectId",
        .revision = "revision",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFormTypeInput, options: CallOptions) !GetFormTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFormTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/form-types/");
    try path_buf.appendSlice(allocator, input.form_type_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFormTypeOutput {
    const result: GetFormTypeOutput = try aws.json.parseJsonObject(
        GetFormTypeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
