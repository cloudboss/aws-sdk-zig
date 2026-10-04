const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetKind = @import("dataset_kind.zig").DatasetKind;
const DatasetOwnerInfo = @import("dataset_owner_info.zig").DatasetOwnerInfo;
const PermissionGroupParams = @import("permission_group_params.zig").PermissionGroupParams;
const SchemaUnion = @import("schema_union.zig").SchemaUnion;

pub const CreateDatasetInput = struct {
    /// The unique resource identifier for a Dataset.
    alias: ?[]const u8 = null,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// Description of a Dataset.
    dataset_description: ?[]const u8 = null,

    /// Display title for a FinSpace Dataset.
    dataset_title: []const u8,

    /// The format in which Dataset data is structured.
    ///
    /// * `TABULAR` – Data is structured in a tabular format.
    ///
    /// * `NON_TABULAR` – Data is structured in a non-tabular format.
    kind: DatasetKind,

    /// Contact information for a Dataset owner.
    owner_info: ?DatasetOwnerInfo = null,

    /// Permission group parameters for Dataset permissions.
    permission_group_params: PermissionGroupParams,

    /// Definition for a schema on a tabular Dataset.
    schema_definition: ?SchemaUnion = null,

    pub const json_field_names = .{
        .alias = "alias",
        .client_token = "clientToken",
        .dataset_description = "datasetDescription",
        .dataset_title = "datasetTitle",
        .kind = "kind",
        .owner_info = "ownerInfo",
        .permission_group_params = "permissionGroupParams",
        .schema_definition = "schemaDefinition",
    };
};

pub const CreateDatasetOutput = struct {
    /// The unique identifier for the created Dataset.
    dataset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetInput, options: CallOptions) !CreateDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/datasetsv2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dataset_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datasetDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"datasetTitle\":");
    try aws.json.writeValue(@TypeOf(input.dataset_title), input.dataset_title, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"kind\":");
    try aws.json.writeValue(@TypeOf(input.kind), input.kind, allocator, &body_buf);
    has_prev = true;
    if (input.owner_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ownerInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"permissionGroupParams\":");
    try aws.json.writeValue(@TypeOf(input.permission_group_params), input.permission_group_params, allocator, &body_buf);
    has_prev = true;
    if (input.schema_definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schemaDefinition\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    var result: CreateDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
