const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionCategory = @import("action_category.zig").ActionCategory;
const SsmExternalParameter = @import("ssm_external_parameter.zig").SsmExternalParameter;
const SsmParameterStoreParameter = @import("ssm_parameter_store_parameter.zig").SsmParameterStoreParameter;

pub const PutSourceServerActionInput = struct {
    /// Source server post migration custom account ID.
    account_id: ?[]const u8 = null,

    /// Source server post migration custom action ID.
    action_id: []const u8,

    /// Source server post migration custom action name.
    action_name: []const u8,

    /// Source server post migration custom action active status.
    active: ?bool = null,

    /// Source server post migration custom action category.
    category: ?ActionCategory = null,

    /// Source server post migration custom action description.
    description: ?[]const u8 = null,

    /// Source server post migration custom action document identifier.
    document_identifier: []const u8,

    /// Source server post migration custom action document version.
    document_version: ?[]const u8 = null,

    /// Source server post migration custom action external parameters.
    external_parameters: ?[]const aws.map.MapEntry(SsmExternalParameter) = null,

    /// Source server post migration custom action must succeed for cutover.
    must_succeed_for_cutover: ?bool = null,

    /// Source server post migration custom action order.
    order: i32,

    /// Source server post migration custom action parameters.
    parameters: ?[]const aws.map.MapEntry([]const SsmParameterStoreParameter) = null,

    /// Source server ID.
    source_server_id: []const u8,

    /// Source server post migration custom action timeout in seconds.
    timeout_seconds: ?i32 = null,

    pub const json_field_names = .{
        .account_id = "accountID",
        .action_id = "actionID",
        .action_name = "actionName",
        .active = "active",
        .category = "category",
        .description = "description",
        .document_identifier = "documentIdentifier",
        .document_version = "documentVersion",
        .external_parameters = "externalParameters",
        .must_succeed_for_cutover = "mustSucceedForCutover",
        .order = "order",
        .parameters = "parameters",
        .source_server_id = "sourceServerID",
        .timeout_seconds = "timeoutSeconds",
    };
};

pub const PutSourceServerActionOutput = @import("source_server_action_document.zig").SourceServerActionDocument;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSourceServerActionInput, options: CallOptions) !PutSourceServerActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSourceServerActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgn", "mgn", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutSourceServerAction";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountID\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionID\":");
    try aws.json.writeValue(@TypeOf(input.action_id), input.action_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionName\":");
    try aws.json.writeValue(@TypeOf(input.action_name), input.action_name, allocator, &body_buf);
    has_prev = true;
    if (input.active) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"active\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.category) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"category\":");
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
    try body_buf.appendSlice(allocator, "\"documentIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.document_identifier), input.document_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.document_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"documentVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.external_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"externalParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.must_succeed_for_cutover) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mustSucceedForCutover\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"order\":");
    try aws.json.writeValue(@TypeOf(input.order), input.order, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerID\":");
    try aws.json.writeValue(@TypeOf(input.source_server_id), input.source_server_id, allocator, &body_buf);
    has_prev = true;
    if (input.timeout_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutSeconds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSourceServerActionOutput {
    var result: PutSourceServerActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutSourceServerActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
