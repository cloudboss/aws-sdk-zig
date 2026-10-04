const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Model = @import("model.zig").Model;
const FormTypeStatus = @import("form_type_status.zig").FormTypeStatus;

pub const CreateFormTypeInput = struct {
    /// The description of this Amazon DataZone metadata form type.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this metadata form type is
    /// created.
    domain_identifier: []const u8,

    /// The model of this Amazon DataZone metadata form type.
    model: Model,

    /// The name of this Amazon DataZone metadata form type.
    name: []const u8,

    /// The ID of the Amazon DataZone project that owns this metadata form type.
    owning_project_identifier: []const u8,

    /// The status of this Amazon DataZone metadata form type.
    status: ?FormTypeStatus = null,

    pub const json_field_names = .{
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .model = "model",
        .name = "name",
        .owning_project_identifier = "owningProjectIdentifier",
        .status = "status",
    };
};

pub const CreateFormTypeOutput = struct {
    /// The description of this Amazon DataZone metadata form type.
    description: ?[]const u8 = null,

    /// The ID of the Amazon DataZone domain in which this metadata form type is
    /// created.
    domain_id: []const u8,

    /// The name of this Amazon DataZone metadata form type.
    name: []const u8,

    /// The ID of the Amazon DataZone domain in which this metadata form type was
    /// originally created.
    origin_domain_id: ?[]const u8 = null,

    /// The ID of the project in which this Amazon DataZone metadata form type was
    /// originally created.
    origin_project_id: ?[]const u8 = null,

    /// The ID of the project that owns this Amazon DataZone metadata form type.
    owning_project_id: ?[]const u8 = null,

    /// The revision of this Amazon DataZone metadata form type.
    revision: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .domain_id = "domainId",
        .name = "name",
        .origin_domain_id = "originDomainId",
        .origin_project_id = "originProjectId",
        .owning_project_id = "owningProjectId",
        .revision = "revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFormTypeInput, options: CallOptions) !CreateFormTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFormTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/form-types");
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
    try body_buf.appendSlice(allocator, "\"model\":");
    try aws.json.writeValue(@TypeOf(input.model), input.model, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFormTypeOutput {
    var result: CreateFormTypeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFormTypeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
