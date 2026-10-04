const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataViewDestinationTypeParams = @import("data_view_destination_type_params.zig").DataViewDestinationTypeParams;
const DataViewErrorInfo = @import("data_view_error_info.zig").DataViewErrorInfo;
const DataViewStatus = @import("data_view_status.zig").DataViewStatus;

pub const GetDataViewInput = struct {
    /// The unique identifier for the Dataset used in the Dataview.
    dataset_id: []const u8,

    /// The unique identifier for the Dataview.
    data_view_id: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .data_view_id = "dataViewId",
    };
};

pub const GetDataViewOutput = struct {
    /// Time range to use for the Dataview. The value is determined as epoch time in
    /// milliseconds. For example, the value for Monday, November 1, 2021 12:00:00
    /// PM UTC is specified as 1635768000000.
    as_of_timestamp: ?i64 = null,

    /// Flag to indicate Dataview should be updated automatically.
    auto_update: ?bool = null,

    /// The timestamp at which the Dataview was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: ?i64 = null,

    /// The unique identifier for the Dataset used in the Dataview.
    dataset_id: ?[]const u8 = null,

    /// The ARN identifier of the Dataview.
    data_view_arn: ?[]const u8 = null,

    /// The unique identifier for the Dataview.
    data_view_id: ?[]const u8 = null,

    /// Options that define the destination type for the Dataview.
    destination_type_params: ?DataViewDestinationTypeParams = null,

    /// Information about an error that occurred for the Dataview.
    error_info: ?DataViewErrorInfo = null,

    /// The last time that a Dataview was modified. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_time: ?i64 = null,

    /// Ordered set of column names used to partition data.
    partition_columns: ?[]const []const u8 = null,

    /// Columns to be used for sorting the data.
    sort_columns: ?[]const []const u8 = null,

    /// The status of a Dataview creation.
    ///
    /// * `RUNNING` – Dataview creation is running.
    ///
    /// * `STARTING` – Dataview creation is starting.
    ///
    /// * `FAILED` – Dataview creation has failed.
    ///
    /// * `CANCELLED` – Dataview creation has been cancelled.
    ///
    /// * `TIMEOUT` – Dataview creation has timed out.
    ///
    /// * `SUCCESS` – Dataview creation has succeeded.
    ///
    /// * `PENDING` – Dataview creation is pending.
    ///
    /// * `FAILED_CLEANUP_FAILED` – Dataview creation failed and resource cleanup
    ///   failed.
    status: ?DataViewStatus = null,

    pub const json_field_names = .{
        .as_of_timestamp = "asOfTimestamp",
        .auto_update = "autoUpdate",
        .create_time = "createTime",
        .dataset_id = "datasetId",
        .data_view_arn = "dataViewArn",
        .data_view_id = "dataViewId",
        .destination_type_params = "destinationTypeParams",
        .error_info = "errorInfo",
        .last_modified_time = "lastModifiedTime",
        .partition_columns = "partitionColumns",
        .sort_columns = "sortColumns",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataViewInput, options: CallOptions) !GetDataViewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/dataviewsv2/");
    try path_buf.appendSlice(allocator, input.data_view_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataViewOutput {
    var result: GetDataViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
