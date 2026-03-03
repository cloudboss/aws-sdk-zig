const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RDSDataSpec = @import("rds_data_spec.zig").RDSDataSpec;

pub const CreateDataSourceFromRDSInput = struct {
    /// The compute statistics for a `DataSource`. The statistics are generated from
    /// the observation data referenced by
    /// a `DataSource`. Amazon ML uses the statistics internally during `MLModel`
    /// training.
    /// This parameter must be set to `true` if the ``DataSource`` needs to be used
    /// for `MLModel` training.
    compute_statistics: ?bool = null,

    /// A user-supplied ID that uniquely identifies the `DataSource`. Typically, an
    /// Amazon Resource Number (ARN)
    /// becomes the ID for a `DataSource`.
    data_source_id: []const u8,

    /// A user-supplied name or description of the `DataSource`.
    data_source_name: ?[]const u8 = null,

    /// The data specification of an Amazon RDS `DataSource`:
    ///
    /// * DatabaseInformation -
    ///
    /// * `DatabaseName` - The name of the Amazon RDS database.
    ///
    /// * `InstanceIdentifier ` - A unique identifier for the Amazon RDS database
    ///   instance.
    ///
    /// * DatabaseCredentials - AWS Identity and Access Management (IAM) credentials
    ///   that are used to connect to the Amazon RDS database.
    ///
    /// * ResourceRole - A role (DataPipelineDefaultResourceRole) assumed by an EC2
    ///   instance to carry out the copy task from Amazon RDS to Amazon
    /// Simple Storage Service (Amazon S3). For more information, see [Role
    /// templates](https://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-iam-roles.html) for data pipelines.
    ///
    /// * ServiceRole - A role (DataPipelineDefaultRole) assumed by the AWS Data
    ///   Pipeline service to monitor the progress of the copy task from Amazon RDS
    /// to Amazon S3. For more information, see [Role
    /// templates](https://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-iam-roles.html) for data pipelines.
    ///
    /// * SecurityInfo - The security information to use to access an RDS DB
    ///   instance. You need to set up appropriate ingress rules for the security
    ///   entity IDs provided to allow access to the Amazon RDS instance. Specify a
    ///   [`SubnetId`, `SecurityGroupIds`] pair for a VPC-based RDS DB instance.
    ///
    /// * SelectSqlQuery - A query that is used to retrieve the observation data for
    ///   the `Datasource`.
    ///
    /// * S3StagingLocation - The Amazon S3 location for staging Amazon RDS data.
    ///   The data retrieved from Amazon RDS using `SelectSqlQuery` is stored in
    ///   this location.
    ///
    /// * DataSchemaUri - The Amazon S3 location of the `DataSchema`.
    ///
    /// * DataSchema - A JSON string representing the schema. This is not required
    ///   if `DataSchemaUri` is specified.
    ///
    /// * DataRearrangement - A JSON string that represents the splitting and
    ///   rearrangement requirements for the `Datasource`.
    ///
    /// Sample -
    /// ` "{\"splitting\":{\"percentBegin\":10,\"percentEnd\":60}}"`
    rds_data: RDSDataSpec,

    /// The role that Amazon ML assumes on behalf of the user to create and activate
    /// a data
    /// pipeline in the user's account and copy data using the `SelectSqlQuery`
    /// query from Amazon RDS to Amazon S3.
    role_arn: []const u8,

    pub const json_field_names = .{
        .compute_statistics = "ComputeStatistics",
        .data_source_id = "DataSourceId",
        .data_source_name = "DataSourceName",
        .rds_data = "RDSData",
        .role_arn = "RoleARN",
    };
};

pub const CreateDataSourceFromRDSOutput = struct {
    /// A user-supplied ID that uniquely identifies the datasource. This value
    /// should be identical to the value of the
    /// `DataSourceID` in the request.
    data_source_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataSourceFromRDSInput, options: Options) !CreateDataSourceFromRDSOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSourceFromRDSInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonML_20141212.CreateDataSourceFromRDS");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataSourceFromRDSOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataSourceFromRDSOutput, body, allocator);
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
