const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataGenerationRunTarget = @import("metadata_generation_run_target.zig").MetadataGenerationRunTarget;
const MetadataGenerationRunType = @import("metadata_generation_run_type.zig").MetadataGenerationRunType;
const MetadataGenerationRunStatus = @import("metadata_generation_run_status.zig").MetadataGenerationRunStatus;

pub const StartMetadataGenerationRunInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain where you want to start a metadata
    /// generation run.
    domain_identifier: []const u8,

    /// The ID of the project that owns the asset for which you want to start a
    /// metadata generation run.
    owning_project_identifier: []const u8,

    /// The asset for which you want to start a metadata generation run.
    target: MetadataGenerationRunTarget,

    /// The type of the metadata generation run.
    @"type": ?MetadataGenerationRunType = null,

    /// The types of the metadata generation run.
    types: ?[]const MetadataGenerationRunType = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .owning_project_identifier = "owningProjectIdentifier",
        .target = "target",
        .@"type" = "type",
        .types = "types",
    };
};

pub const StartMetadataGenerationRunOutput = struct {
    /// The timestamp at which the metadata generation run was started.
    created_at: ?i64 = null,

    /// The ID of the user who started the metadata generation run.
    created_by: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the metadata generation run
    /// was started.
    domain_id: []const u8,

    /// The ID of the metadata generation run.
    id: []const u8,

    /// The ID of the project that owns the asset for which the metadata generation
    /// run was started.
    owning_project_id: ?[]const u8 = null,

    /// The status of the metadata generation run.
    status: ?MetadataGenerationRunStatus = null,

    /// The type of the metadata generation run.
    @"type": ?MetadataGenerationRunType = null,

    /// The types of the metadata generation run.
    types: ?[]const MetadataGenerationRunType = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .owning_project_id = "owningProjectId",
        .status = "status",
        .@"type" = "type",
        .types = "types",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMetadataGenerationRunInput, options: CallOptions) !StartMetadataGenerationRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMetadataGenerationRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/metadata-generation-runs");
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
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
    has_prev = true;
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"types\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMetadataGenerationRunOutput {
    const result: StartMetadataGenerationRunOutput = try aws.json.parseJsonObject(
        StartMetadataGenerationRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
