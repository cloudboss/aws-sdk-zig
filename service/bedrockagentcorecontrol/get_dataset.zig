const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DraftStatus = @import("draft_status.zig").DraftStatus;
const DatasetSchemaType = @import("dataset_schema_type.zig").DatasetSchemaType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const GetDatasetInput = struct {
    /// The unique identifier of the dataset to retrieve.
    dataset_id: []const u8,

    /// Version to retrieve: "DRAFT" or a version number. Defaults to DRAFT if
    /// absent.
    dataset_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .dataset_version = "datasetVersion",
    };
};

pub const GetDatasetOutput = struct {
    /// The timestamp when the dataset was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    /// The unique identifier of the dataset.
    dataset_id: []const u8,

    /// The name of the dataset.
    dataset_name: []const u8,

    /// The resolved version: "DRAFT" (default) or the requested version number.
    dataset_version: []const u8,

    /// The description of the dataset.
    description: ?[]const u8 = null,

    /// Presigned Amazon S3 URL to download the consolidated dataset file for the
    /// resolved version. Expires after 5 minutes. Omitted if the file does not yet
    /// exist.
    download_url: ?[]const u8 = null,

    /// Expiry timestamp for the download URL.
    download_url_expires_at: ?i64 = null,

    /// Publish synchronization state. Only authoritative when status is ACTIVE.
    /// MODIFIED indicates DRAFT has unpublished changes. UNMODIFIED indicates DRAFT
    /// matches the latest published version.
    draft_status: ?DraftStatus = null,

    /// The number of examples in the DRAFT.
    example_count: i64,

    /// Populated when status is CREATE_FAILED, UPDATE_FAILED, or DELETE_FAILED.
    /// Describes the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// KMS key ARN used for server-side encryption on service Amazon S3 writes, if
    /// configured.
    kms_key_arn: ?[]const u8 = null,

    /// The schema type declared at create time. Immutable after creation.
    schema_type: DatasetSchemaType,

    /// The current status of the dataset.
    status: DatasetStatus,

    /// The tags associated with the dataset.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the dataset was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .dataset_arn = "datasetArn",
        .dataset_id = "datasetId",
        .dataset_name = "datasetName",
        .dataset_version = "datasetVersion",
        .description = "description",
        .download_url = "downloadUrl",
        .download_url_expires_at = "downloadUrlExpiresAt",
        .draft_status = "draftStatus",
        .example_count = "exampleCount",
        .failure_reason = "failureReason",
        .kms_key_arn = "kmsKeyArn",
        .schema_type = "schemaType",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDatasetInput, options: CallOptions) !GetDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dataset_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "datasetVersion=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDatasetOutput {
    const result: GetDatasetOutput = try aws.json.parseJsonObject(
        GetDatasetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
