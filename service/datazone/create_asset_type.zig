const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FormEntryInput = @import("form_entry_input.zig").FormEntryInput;
const FormEntryOutput = @import("form_entry_output.zig").FormEntryOutput;

pub const CreateAssetTypeInput = struct {
    /// The descripton of the custom asset type.
    description: ?[]const u8 = null,

    /// The unique identifier of the Amazon DataZone domain where the custom asset
    /// type is being created.
    domain_identifier: []const u8,

    /// The metadata forms that are to be attached to the custom asset type.
    forms_input: []const aws.map.MapEntry(FormEntryInput),

    /// The name of the custom asset type.
    name: []const u8,

    /// The identifier of the Amazon DataZone project that is to own the custom
    /// asset type.
    owning_project_identifier: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .forms_input = "formsInput",
        .name = "name",
        .owning_project_identifier = "owningProjectIdentifier",
    };
};

pub const CreateAssetTypeOutput = struct {
    /// The timestamp of when the asset type is to be created.
    created_at: ?i64 = null,

    /// The Amazon DataZone user who creates this custom asset type.
    created_by: ?[]const u8 = null,

    /// The description of the custom asset type.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which the asset type was created.
    domain_id: []const u8,

    /// The metadata forms that are attached to the asset type.
    forms_output: ?[]const aws.map.MapEntry(FormEntryOutput) = null,

    /// The name of the asset type.
    name: []const u8,

    /// The ID of the Amazon DataZone domain where the asset type was originally
    /// created.
    origin_domain_id: ?[]const u8 = null,

    /// The ID of the Amazon DataZone project where the asset type was originally
    /// created.
    origin_project_id: ?[]const u8 = null,

    /// The ID of the Amazon DataZone project that currently owns this asset type.
    owning_project_id: ?[]const u8 = null,

    /// The revision of the custom asset type.
    revision: []const u8,

    /// The timestamp of when the custom type was created.
    updated_at: ?i64 = null,

    /// The Amazon DataZone user that created the custom asset type.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssetTypeInput, options: CallOptions) !CreateAssetTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssetTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/asset-types");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"formsInput\":");
    try aws.json.writeValue(@TypeOf(input.forms_input), input.forms_input, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssetTypeOutput {
    var result: CreateAssetTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAssetTypeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
