const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataGenerationRunType = @import("metadata_generation_run_type.zig").MetadataGenerationRunType;
const MetadataGenerationRunStatus = @import("metadata_generation_run_status.zig").MetadataGenerationRunStatus;
const MetadataGenerationRunTarget = @import("metadata_generation_run_target.zig").MetadataGenerationRunTarget;
const MetadataGenerationRunTypeStat = @import("metadata_generation_run_type_stat.zig").MetadataGenerationRunTypeStat;

pub const GetMetadataGenerationRunInput = struct {
    /// The ID of the Amazon DataZone domain the metadata generation run of which
    /// you want to get.
    domain_identifier: []const u8,

    /// The identifier of the metadata generation run.
    identifier: []const u8,

    /// The type of the metadata generation run.
    @"type": ?MetadataGenerationRunType = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .@"type" = "type",
    };
};

pub const GetMetadataGenerationRunOutput = struct {
    /// The timestamp of when the metadata generation run was start.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who started the metadata generation run.
    created_by: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain the metadata generation run of which
    /// you want to get.
    domain_id: []const u8,

    /// The ID of the metadata generation run.
    id: []const u8,

    /// The ID of the project that owns the assets for which you're running metadata
    /// generation.
    owning_project_id: []const u8,

    /// The status of the metadata generation run.
    status: ?MetadataGenerationRunStatus = null,

    /// The asset for which you're generating metadata.
    target: ?MetadataGenerationRunTarget = null,

    /// The type of metadata generation run.
    @"type": ?MetadataGenerationRunType = null,

    /// The types of the metadata generation run.
    types: ?[]const MetadataGenerationRunType = null,

    /// The type stats included in the metadata generation run output details.
    type_stats: ?[]const MetadataGenerationRunTypeStat = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .owning_project_id = "owningProjectId",
        .status = "status",
        .target = "target",
        .@"type" = "type",
        .types = "types",
        .type_stats = "typeStats",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetadataGenerationRunInput, options: CallOptions) !GetMetadataGenerationRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetadataGenerationRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/metadata-generation-runs/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.@"type") |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetadataGenerationRunOutput {
    const result: GetMetadataGenerationRunOutput = try aws.json.parseJsonObject(
        GetMetadataGenerationRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
