const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Descriptors = @import("descriptors.zig").Descriptors;
const Provenance = @import("provenance.zig").Provenance;
const RecordType = @import("record_type.zig").RecordType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

pub const CreateRegistryRecordInput = struct {
    /// Client token for idempotency
    client_token: ?[]const u8 = null,

    /// The custom metadata to attach to the registry record. Each key must match a
    /// property defined in the registry's custom metadata schema. Values can be
    /// strings (maximum 128 characters) or native JSON booleans (`true` or
    /// `false`). Values are validated against the schema at creation time.
    custom_metadata: ?[]const u8 = null,

    /// The description of the registry record
    description: ?[]const u8 = null,

    /// The typed descriptor content for the registry record
    descriptors: Descriptors,

    /// The human-readable display name of the registry record
    display_name: ?[]const u8 = null,

    /// The name of the registry record
    name: []const u8,

    /// The provenance lineage entries for the registry record. This field is
    /// reserved for the Amazon Web Services Agent Registry auto-detection service
    /// principal. Requests that include this field from other callers are rejected.
    provenance: ?[]const Provenance = null,

    /// The type of the registry record, which determines the descriptor format
    record_type: RecordType,

    /// The version of the registry record
    record_version: ?[]const u8 = null,

    /// The identifier of the registry in which to create the record (ARN or ID)
    registry_id: []const u8,

    /// Tags to associate with the registry record
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .custom_metadata = "customMetadata",
        .description = "description",
        .descriptors = "descriptors",
        .display_name = "displayName",
        .name = "name",
        .provenance = "provenance",
        .record_type = "recordType",
        .record_version = "recordVersion",
        .registry_id = "registryId",
        .tags = "tags",
    };
};

pub const CreateRegistryRecordOutput = struct {
    /// The ARN of the created registry record
    record_arn: []const u8,

    /// The status of the registry record, set to CREATING while the asynchronous
    /// workflow is in progress
    status: RegistryRecordStatus,

    pub const json_field_names = .{
        .record_arn = "recordArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistryRecordInput, options: CallOptions) !CreateRegistryRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "agent-registry", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistryRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry-control", "Agent Registry Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records");
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
    if (input.custom_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"descriptors\":");
    try aws.json.writeValue(@TypeOf(input.descriptors), input.descriptors, allocator, &body_buf);
    has_prev = true;
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.provenance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provenance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"recordType\":");
    try aws.json.writeValue(@TypeOf(input.record_type), input.record_type, allocator, &body_buf);
    has_prev = true;
    if (input.record_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistryRecordOutput {
    const result: CreateRegistryRecordOutput = try aws.json.parseJsonObject(
        CreateRegistryRecordOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
