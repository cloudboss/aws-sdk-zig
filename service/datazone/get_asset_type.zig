const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FormEntryOutput = @import("form_entry_output.zig").FormEntryOutput;

pub const GetAssetTypeInput = struct {
    /// The ID of the Amazon DataZone domain in which the asset type exists.
    domain_identifier: []const u8,

    /// The ID of the asset type.
    identifier: []const u8,

    /// The revision of the asset type.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .revision = "revision",
    };
};

pub const GetAssetTypeOutput = struct {
    /// The timestamp of when the asset type was created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who created the asset type.
    created_by: ?[]const u8 = null,

    /// The description of the asset type.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the asset type exists.
    domain_id: []const u8,

    /// The metadata forms attached to the asset type.
    forms_output: ?[]const aws.map.MapEntry(FormEntryOutput) = null,

    /// The name of the asset type.
    name: []const u8,

    /// The ID of the Amazon DataZone domain in which the asset type was originally
    /// created.
    origin_domain_id: ?[]const u8 = null,

    /// The ID of the Amazon DataZone project in which the asset type was originally
    /// created.
    origin_project_id: ?[]const u8 = null,

    /// The ID of the Amazon DataZone project that owns the asset type.
    owning_project_id: []const u8,

    /// The revision of the asset type.
    revision: []const u8,

    /// The timestamp of when the asset type was updated.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user that updated the asset type.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .forms_output = "formsOutput",
        .name = "name",
        .origin_domain_id = "originDomainId",
        .origin_project_id = "originProjectId",
        .owning_project_id = "owningProjectId",
        .revision = "revision",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssetTypeInput, options: CallOptions) !GetAssetTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssetTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/asset-types/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssetTypeOutput {
    var result: GetAssetTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAssetTypeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
