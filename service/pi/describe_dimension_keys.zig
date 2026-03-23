const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DimensionGroup = @import("dimension_group.zig").DimensionGroup;
const ServiceType = @import("service_type.zig").ServiceType;
const DimensionKeyDescription = @import("dimension_key_description.zig").DimensionKeyDescription;
const ResponsePartitionKey = @import("response_partition_key.zig").ResponsePartitionKey;

pub const DescribeDimensionKeysInput = struct {
    /// Additional metrics for the top `N` dimension keys. If the specified
    /// dimension group in the `GroupBy` parameter is
    /// `db.sql_tokenized`, you can specify per-SQL metrics to get the values for
    /// the top `N` SQL digests. The response
    /// syntax is as follows: `"AdditionalMetrics" : { "*string*" : "*string*" }`.
    ///
    /// The only supported statistic function is `.avg`.
    additional_metrics: ?[]const []const u8 = null,

    /// The date and time specifying the end of the requested time series data. The
    /// value specified is
    /// *exclusive*, which means that data points less than (but not equal to)
    /// `EndTime` are
    /// returned.
    ///
    /// The value for `EndTime` must be later than the value for `StartTime`.
    end_time: i64,

    /// One or more filters to apply in the request. Restrictions:
    ///
    /// * Any number of filters by the same dimension, as specified in the `GroupBy`
    ///   or
    /// `Partition` parameters.
    ///
    /// * A single filter for any other dimension in this dimension group.
    ///
    /// The `db.sql.db_id` filter isn't available for RDS for SQL Server DB
    /// instances.
    filter: ?[]const aws.map.StringMapEntry = null,

    /// A specification for how to aggregate the data points from a query result.
    /// You must specify a valid dimension group. Performance Insights returns all
    /// dimensions within this group, unless you provide the names of specific
    /// dimensions within this group. You can also request that Performance Insights
    /// return
    /// a limited number of values for a dimension.
    group_by: DimensionGroup,

    /// An immutable, Amazon Web Services Region-unique identifier for a data
    /// source. Performance Insights gathers metrics from
    /// this data source.
    ///
    /// To use an Amazon RDS instance as a data source, you specify its
    /// `DbiResourceId` value.
    /// For example, specify `db-FAIHNTYBKTGAUSUZQYPDS2GW4A`.
    identifier: []const u8,

    /// The maximum number of items to return in the response. If more items exist
    /// than the specified `MaxRecords` value, a
    /// pagination token is included in the response so that the remaining results
    /// can be retrieved.
    max_results: ?i32 = null,

    /// The name of a Performance Insights metric to be measured.
    ///
    /// Valid values for `Metric` are:
    ///
    /// * `db.load.avg` - A scaled representation of the number of active sessions
    ///   for the database engine.
    ///
    /// * `db.sampledload.avg` - The raw number of active sessions for the database
    ///   engine.
    ///
    /// If the number of active sessions is less than an internal Performance
    /// Insights threshold, `db.load.avg`
    /// and `db.sampledload.avg` are the same value. If the number of active
    /// sessions is greater than
    /// the internal threshold, Performance Insights samples the active sessions,
    /// with `db.load.avg`
    /// showing the scaled values, `db.sampledload.avg` showing the raw values, and
    /// `db.sampledload.avg` less than `db.load.avg`. For most use cases, you can
    /// query `db.load.avg` only.
    metric: []const u8,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond
    /// the token, up to the value specified by `MaxRecords`.
    next_token: ?[]const u8 = null,

    /// For each dimension specified in `GroupBy`, specify a secondary dimension
    /// to further subdivide the partition keys in the response.
    partition_by: ?DimensionGroup = null,

    /// The granularity, in seconds, of the data points returned from Performance
    /// Insights. A period can be as short as
    /// one second, or as long as one day (86400 seconds). Valid values are:
    ///
    /// * `1` (one second)
    ///
    /// * `60` (one minute)
    ///
    /// * `300` (five minutes)
    ///
    /// * `3600` (one hour)
    ///
    /// * `86400` (twenty-four hours)
    ///
    /// If you don't specify `PeriodInSeconds`, then Performance Insights chooses a
    /// value for you, with a
    /// goal of returning roughly 100-200 data points in the response.
    period_in_seconds: ?i32 = null,

    /// The Amazon Web Services service for which Performance Insights will return
    /// metrics. Valid values are as follows:
    ///
    /// * `RDS`
    ///
    /// * `DOCDB`
    service_type: ServiceType,

    /// The date and time specifying the beginning of the requested time series
    /// data. You must specify a
    /// `StartTime` within the past 7 days. The value specified is *inclusive*,
    /// which means that data points equal to or greater than `StartTime` are
    /// returned.
    ///
    /// The value for `StartTime` must be earlier than the value for `EndTime`.
    start_time: i64,

    pub const json_field_names = .{
        .additional_metrics = "AdditionalMetrics",
        .end_time = "EndTime",
        .filter = "Filter",
        .group_by = "GroupBy",
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .metric = "Metric",
        .next_token = "NextToken",
        .partition_by = "PartitionBy",
        .period_in_seconds = "PeriodInSeconds",
        .service_type = "ServiceType",
        .start_time = "StartTime",
    };
};

pub const DescribeDimensionKeysOutput = struct {
    /// The end time for the returned dimension keys, after alignment to a granular
    /// boundary (as specified by `PeriodInSeconds`).
    /// `AlignedEndTime` will be greater than or equal to the value of the
    /// user-specified `Endtime`.
    aligned_end_time: ?i64 = null,

    /// The start time for the returned dimension keys, after alignment to a
    /// granular boundary (as specified by `PeriodInSeconds`).
    /// `AlignedStartTime` will be less than or equal to the value of the
    /// user-specified `StartTime`.
    aligned_start_time: ?i64 = null,

    /// The dimension keys that were requested.
    keys: ?[]const DimensionKeyDescription = null,

    /// A pagination token that indicates the response didn’t return all available
    /// records because `MaxRecords` was specified in the
    /// previous request. To get the remaining records, specify `NextToken` in a
    /// separate request with this value.
    next_token: ?[]const u8 = null,

    /// If `PartitionBy` was present in the request, `PartitionKeys` contains the
    /// breakdown of dimension keys by the
    /// specified partitions.
    partition_keys: ?[]const ResponsePartitionKey = null,

    pub const json_field_names = .{
        .aligned_end_time = "AlignedEndTime",
        .aligned_start_time = "AlignedStartTime",
        .keys = "Keys",
        .next_token = "NextToken",
        .partition_keys = "PartitionKeys",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDimensionKeysInput, options: CallOptions) !DescribeDimensionKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pi");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDimensionKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "PerformanceInsightsv20180227.DescribeDimensionKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDimensionKeysOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDimensionKeysOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
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
