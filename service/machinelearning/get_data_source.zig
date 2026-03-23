const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RDSMetadata = @import("rds_metadata.zig").RDSMetadata;
const RedshiftMetadata = @import("redshift_metadata.zig").RedshiftMetadata;
const EntityStatus = @import("entity_status.zig").EntityStatus;

pub const GetDataSourceInput = struct {
    /// The ID assigned to the `DataSource` at creation.
    data_source_id: []const u8,

    /// Specifies whether the `GetDataSource` operation should return
    /// `DataSourceSchema`.
    ///
    /// If true, `DataSourceSchema` is returned.
    ///
    /// If false, `DataSourceSchema` is not returned.
    verbose: ?bool = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .verbose = "Verbose",
    };
};

pub const GetDataSourceOutput = struct {
    /// The parameter is `true` if statistics need to be generated from the
    /// observation data.
    compute_statistics: ?bool = null,

    /// The approximate CPU time in milliseconds that Amazon Machine Learning spent
    /// processing the `DataSource`, normalized and scaled on computation resources.
    /// `ComputeTime` is only available if the `DataSource` is in the `COMPLETED`
    /// state and the `ComputeStatistics` is set to true.
    compute_time: ?i64 = null,

    /// The time that the `DataSource` was created. The time is expressed in epoch
    /// time.
    created_at: ?i64 = null,

    /// The AWS user account from which the `DataSource` was created. The account
    /// type can be either an AWS root account or an AWS Identity and Access
    /// Management (IAM) user account.
    created_by_iam_user: ?[]const u8 = null,

    /// The location of the data file or directory in Amazon Simple Storage Service
    /// (Amazon S3).
    data_location_s3: ?[]const u8 = null,

    /// A JSON string that represents the splitting and rearrangement requirement
    /// used when this `DataSource`
    /// was created.
    data_rearrangement: ?[]const u8 = null,

    /// The total size of observations in the data files.
    data_size_in_bytes: ?i64 = null,

    /// The ID assigned to the `DataSource` at creation. This value should be
    /// identical to the value of the `DataSourceId` in the request.
    data_source_id: ?[]const u8 = null,

    /// The schema used by all of the data files of this `DataSource`.
    ///
    /// **Note:** This parameter is provided as part of the verbose format.
    data_source_schema: ?[]const u8 = null,

    /// The epoch time when Amazon Machine Learning marked the `DataSource` as
    /// `COMPLETED` or `FAILED`. `FinishedAt` is only available when the
    /// `DataSource` is in the `COMPLETED` or `FAILED` state.
    finished_at: ?i64 = null,

    /// The time of the most recent edit to the `DataSource`. The time is expressed
    /// in epoch time.
    last_updated_at: ?i64 = null,

    /// A link to the file containing logs of `CreateDataSourceFrom*` operations.
    log_uri: ?[]const u8 = null,

    /// The user-supplied description of the most recent details about creating the
    /// `DataSource`.
    message: ?[]const u8 = null,

    /// A user-supplied name or description of the `DataSource`.
    name: ?[]const u8 = null,

    /// The number of data files referenced by the `DataSource`.
    number_of_files: ?i64 = null,

    rds_metadata: ?RDSMetadata = null,

    redshift_metadata: ?RedshiftMetadata = null,

    role_arn: ?[]const u8 = null,

    /// The epoch time when Amazon Machine Learning marked the `DataSource` as
    /// `INPROGRESS`. `StartedAt` isn't available if the `DataSource` is in the
    /// `PENDING` state.
    started_at: ?i64 = null,

    /// The current status of the `DataSource`. This element can have one of the
    /// following values:
    ///
    /// * `PENDING` - Amazon ML submitted a request to create a `DataSource`.
    ///
    /// * `INPROGRESS` - The creation process is underway.
    ///
    /// * `FAILED` - The request to create a `DataSource` did not run to completion.
    ///   It is not usable.
    ///
    /// * `COMPLETED` - The creation process completed successfully.
    ///
    /// * `DELETED` - The `DataSource` is marked as deleted. It is not usable.
    status: ?EntityStatus = null,

    pub const json_field_names = .{
        .compute_statistics = "ComputeStatistics",
        .compute_time = "ComputeTime",
        .created_at = "CreatedAt",
        .created_by_iam_user = "CreatedByIamUser",
        .data_location_s3 = "DataLocationS3",
        .data_rearrangement = "DataRearrangement",
        .data_size_in_bytes = "DataSizeInBytes",
        .data_source_id = "DataSourceId",
        .data_source_schema = "DataSourceSchema",
        .finished_at = "FinishedAt",
        .last_updated_at = "LastUpdatedAt",
        .log_uri = "LogUri",
        .message = "Message",
        .name = "Name",
        .number_of_files = "NumberOfFiles",
        .rds_metadata = "RDSMetadata",
        .redshift_metadata = "RedshiftMetadata",
        .role_arn = "RoleARN",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataSourceInput, options: CallOptions) !GetDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "machinelearning");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.GetDataSource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataSourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDataSourceOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PredictorNotMountedException")) {
        return .{ .arena = arena, .kind = .{ .predictor_not_mounted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
