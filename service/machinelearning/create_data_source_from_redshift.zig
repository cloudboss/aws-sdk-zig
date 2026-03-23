const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RedshiftDataSpec = @import("redshift_data_spec.zig").RedshiftDataSpec;

pub const CreateDataSourceFromRedshiftInput = struct {
    /// The compute statistics for a `DataSource`. The statistics are generated from
    /// the observation data referenced by
    /// a `DataSource`. Amazon ML uses the statistics internally during `MLModel`
    /// training.
    /// This parameter must be set to `true` if the `DataSource` needs to
    /// be used for `MLModel` training.
    compute_statistics: ?bool = null,

    /// A user-supplied ID that uniquely identifies the `DataSource`.
    data_source_id: []const u8,

    /// A user-supplied name or description of the `DataSource`.
    data_source_name: ?[]const u8 = null,

    /// The data specification of an Amazon Redshift `DataSource`:
    ///
    /// * DatabaseInformation -
    ///
    /// * `DatabaseName` - The name of the Amazon Redshift database.
    ///
    /// * ` ClusterIdentifier` - The unique ID for the Amazon Redshift cluster.
    ///
    /// * DatabaseCredentials - The AWS Identity and Access Management (IAM)
    ///   credentials that are used to connect to the Amazon Redshift database.
    ///
    /// * SelectSqlQuery - The query that is used to retrieve the observation data
    ///   for the
    /// `Datasource`.
    ///
    /// * S3StagingLocation - The Amazon Simple Storage Service (Amazon S3) location
    ///   for staging Amazon
    /// Redshift data. The data retrieved from Amazon Redshift using
    /// the `SelectSqlQuery` query is stored in this location.
    ///
    /// * DataSchemaUri - The Amazon S3 location of the `DataSchema`.
    ///
    /// * DataSchema - A JSON string representing the schema. This is not required
    ///   if `DataSchemaUri` is specified.
    ///
    /// * DataRearrangement - A JSON string that represents the splitting and
    ///   rearrangement requirements for the `DataSource`.
    ///
    /// Sample -
    /// ` "{\"splitting\":{\"percentBegin\":10,\"percentEnd\":60}}"`
    data_spec: RedshiftDataSpec,

    /// A fully specified role Amazon Resource Name (ARN). Amazon ML assumes the
    /// role on behalf of the user to create the following:
    ///
    /// * A security group to allow Amazon ML to execute the `SelectSqlQuery` query
    ///   on an Amazon Redshift cluster
    ///
    /// * An Amazon S3 bucket policy to grant Amazon ML read/write permissions on
    ///   the `S3StagingLocation`
    role_arn: []const u8,

    pub const json_field_names = .{
        .compute_statistics = "ComputeStatistics",
        .data_source_id = "DataSourceId",
        .data_source_name = "DataSourceName",
        .data_spec = "DataSpec",
        .role_arn = "RoleARN",
    };
};

pub const CreateDataSourceFromRedshiftOutput = struct {
    /// A user-supplied ID that uniquely identifies the datasource. This value
    /// should be identical to the value of the
    /// `DataSourceID` in the request.
    data_source_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSourceFromRedshiftInput, options: CallOptions) !CreateDataSourceFromRedshiftOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSourceFromRedshiftInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.CreateDataSourceFromRedshift");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSourceFromRedshiftOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataSourceFromRedshiftOutput, body, allocator);
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
