const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetKind = @import("dataset_kind.zig").DatasetKind;
const SchemaUnion = @import("schema_union.zig").SchemaUnion;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const GetDatasetInput = struct {
    /// The unique identifier for a Dataset.
    dataset_id: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
    };
};

pub const GetDatasetOutput = struct {
    /// The unique resource identifier for a Dataset.
    alias: ?[]const u8 = null,

    /// The timestamp at which the Dataset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: ?i64 = null,

    /// The ARN identifier of the Dataset.
    dataset_arn: ?[]const u8 = null,

    /// A description of the Dataset.
    dataset_description: ?[]const u8 = null,

    /// The unique identifier for a Dataset.
    dataset_id: ?[]const u8 = null,

    /// Display title for a Dataset.
    dataset_title: ?[]const u8 = null,

    /// The format in which Dataset data is structured.
    ///
    /// * `TABULAR` – Data is structured in a tabular format.
    ///
    /// * `NON_TABULAR` – Data is structured in a non-tabular format.
    kind: ?DatasetKind = null,

    /// The last time that the Dataset was modified. The value is determined as
    /// epoch time in milliseconds. For example, the value for Monday, November 1,
    /// 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_time: ?i64 = null,

    /// Definition for a schema on a tabular Dataset.
    schema_definition: ?SchemaUnion = null,

    /// Status of the Dataset creation.
    ///
    /// * `PENDING` – Dataset is pending creation.
    ///
    /// * `FAILED` – Dataset creation has failed.
    ///
    /// * `SUCCESS` – Dataset creation has succeeded.
    ///
    /// * `RUNNING` – Dataset creation is running.
    status: ?DatasetStatus = null,

    pub const json_field_names = .{
        .alias = "alias",
        .create_time = "createTime",
        .dataset_arn = "datasetArn",
        .dataset_description = "datasetDescription",
        .dataset_id = "datasetId",
        .dataset_title = "datasetTitle",
        .kind = "kind",
        .last_modified_time = "lastModifiedTime",
        .schema_definition = "schemaDefinition",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDatasetInput, options: CallOptions) !GetDatasetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasetsv2/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDatasetOutput {
    var result: GetDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDatasetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
