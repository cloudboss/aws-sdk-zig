const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeType = @import("change_type.zig").ChangeType;
const ChangesetErrorInfo = @import("changeset_error_info.zig").ChangesetErrorInfo;
const IngestionStatus = @import("ingestion_status.zig").IngestionStatus;

pub const GetChangesetInput = struct {
    /// The unique identifier of the Changeset for which to get data.
    changeset_id: []const u8,

    /// The unique identifier for the FinSpace Dataset where the Changeset is
    /// created.
    dataset_id: []const u8,

    pub const json_field_names = .{
        .changeset_id = "changesetId",
        .dataset_id = "datasetId",
    };
};

pub const GetChangesetOutput = struct {
    /// Beginning time from which the Changeset is active. The value is determined
    /// as epoch time in milliseconds. For example, the value for Monday, November
    /// 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    active_from_timestamp: ?i64 = null,

    /// Time until which the Changeset is active. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    active_until_timestamp: ?i64 = null,

    /// The ARN identifier of the Changeset.
    changeset_arn: ?[]const u8 = null,

    /// The unique identifier for a Changeset.
    changeset_id: ?[]const u8 = null,

    /// Type that indicates how a Changeset is applied to a Dataset.
    ///
    /// * `REPLACE` – Changeset is considered as a replacement to all prior loaded
    ///   Changesets.
    ///
    /// * `APPEND` – Changeset is considered as an addition to the end of all prior
    ///   loaded Changesets.
    ///
    /// * `MODIFY` – Changeset is considered as a replacement to a specific prior
    ///   ingested Changeset.
    change_type: ?ChangeType = null,

    /// The timestamp at which the Changeset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: ?i64 = null,

    /// The unique identifier for the FinSpace Dataset where the Changeset is
    /// created.
    dataset_id: ?[]const u8 = null,

    /// The structure with error messages.
    error_info: ?ChangesetErrorInfo = null,

    /// Structure of the source file(s).
    format_params: ?[]const aws.map.StringMapEntry = null,

    /// Options that define the location of the data being ingested.
    source_params: ?[]const aws.map.StringMapEntry = null,

    /// The status of Changeset creation operation.
    status: ?IngestionStatus = null,

    /// The unique identifier of the updated Changeset.
    updated_by_changeset_id: ?[]const u8 = null,

    /// The unique identifier of the Changeset that is being updated.
    updates_changeset_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_from_timestamp = "activeFromTimestamp",
        .active_until_timestamp = "activeUntilTimestamp",
        .changeset_arn = "changesetArn",
        .changeset_id = "changesetId",
        .change_type = "changeType",
        .create_time = "createTime",
        .dataset_id = "datasetId",
        .error_info = "errorInfo",
        .format_params = "formatParams",
        .source_params = "sourceParams",
        .status = "status",
        .updated_by_changeset_id = "updatedByChangesetId",
        .updates_changeset_id = "updatesChangesetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetChangesetInput, options: CallOptions) !GetChangesetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetChangesetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/changesetsv2/");
    try path_buf.appendSlice(allocator, input.changeset_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetChangesetOutput {
    const result: GetChangesetOutput = try aws.json.parseJsonObject(
        GetChangesetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
