const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataDeletionPolicy = @import("data_deletion_policy.zig").DataDeletionPolicy;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const VectorIngestionConfiguration = @import("vector_ingestion_configuration.zig").VectorIngestionConfiguration;
const DataSource = @import("data_source.zig").DataSource;

pub const UpdateDataSourceInput = struct {
    /// The data deletion policy for the data source that you want to update.
    data_deletion_policy: ?DataDeletionPolicy = null,

    /// The connection configuration for the data source that you want to update.
    data_source_configuration: DataSourceConfiguration,

    /// The unique identifier of the data source.
    data_source_id: []const u8,

    /// Specifies a new description for the data source.
    description: ?[]const u8 = null,

    /// The unique identifier of the knowledge base for the data source.
    knowledge_base_id: []const u8,

    /// Specifies a new name for the data source.
    name: []const u8,

    /// Contains details about server-side encryption of the data source.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// Contains details about how to ingest the documents in the data source.
    vector_ingestion_configuration: ?VectorIngestionConfiguration = null,

    pub const json_field_names = .{
        .data_deletion_policy = "dataDeletionPolicy",
        .data_source_configuration = "dataSourceConfiguration",
        .data_source_id = "dataSourceId",
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .vector_ingestion_configuration = "vectorIngestionConfiguration",
    };
};

pub const UpdateDataSourceOutput = struct {
    /// Contains details about the data source.
    data_source: ?DataSource = null,

    pub const json_field_names = .{
        .data_source = "dataSource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataSourceInput, options: CallOptions) !UpdateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_deletion_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataDeletionPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataSourceConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.data_source_configuration), input.data_source_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.server_side_encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serverSideEncryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vector_ingestion_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vectorIngestionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataSourceOutput {
    const result: UpdateDataSourceOutput = try aws.json.parseJsonObject(
        UpdateDataSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
