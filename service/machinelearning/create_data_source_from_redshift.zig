const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "machinelearning", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataSourceFromRedshiftInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("machinelearning", "Machine Learning", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
