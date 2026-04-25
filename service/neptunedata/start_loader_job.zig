const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Format = @import("format.zig").Format;
const Mode = @import("mode.zig").Mode;
const Parallelism = @import("parallelism.zig").Parallelism;
const S3BucketRegion = @import("s3_bucket_region.zig").S3BucketRegion;

pub const StartLoaderJobInput = struct {
    /// This is an optional parameter that can make a queued load request contingent
    /// on the successful completion of one or more previous jobs in the queue.
    ///
    /// Neptune can queue up as many as 64 load requests at a time, if their
    /// `queueRequest` parameters are set to `"TRUE"`. The `dependencies` parameter
    /// lets you make execution of such a queued request dependent on the successful
    /// completion of one or more specified previous requests in the queue.
    ///
    /// For example, if load `Job-A` and `Job-B` are independent of each other, but
    /// load `Job-C` needs `Job-A` and `Job-B` to be finished before it begins,
    /// proceed as follows:
    ///
    /// * Submit `load-job-A` and `load-job-B` one after another in any order, and
    ///   save their load-ids.
    /// * Submit `load-job-C` with the load-ids of the two jobs in its
    ///   `dependencies` field:
    ///
    /// Because of the `dependencies` parameter, the bulk loader will not start
    /// `Job-C` until `Job-A` and `Job-B` have completed successfully. If either one
    /// of them fails, Job-C will not be executed, and its status will be set to
    /// `LOAD_FAILED_BECAUSE_DEPENDENCY_NOT_SATISFIED`.
    ///
    /// You can set up multiple levels of dependency in this way, so that the
    /// failure of one job will cause all requests that are directly or indirectly
    /// dependent on it to be cancelled.
    dependencies: ?[]const []const u8 = null,

    /// ** `edgeOnlyLoad` ** - A flag that controls file processing order during
    /// bulk loading.
    ///
    /// *Allowed values*: `"TRUE"`, `"FALSE"`.
    ///
    /// *Default value*: `"FALSE"`.
    ///
    /// When this parameter is set to "FALSE", the loader automatically loads vertex
    /// files first, then edge files afterwards. It does this by first scanning all
    /// files to determine their contents (vertices or edges). When this parameter
    /// is set to "TRUE", the loader skips the initial scanning phase and
    /// immediately loads all files in the order they appear.
    edge_only_load: ?bool = null,

    /// ** `failOnError` ** - A flag to toggle a complete stop on an error.
    ///
    /// *Allowed values*: `"TRUE"`, `"FALSE"`.
    ///
    /// *Default value*: `"TRUE"`.
    ///
    /// When this parameter is set to `"FALSE"`, the loader tries to load all the
    /// data in the location specified, skipping any entries with errors.
    ///
    /// When this parameter is set to `"TRUE"`, the loader stops as soon as it
    /// encounters an error. Data loaded up to that point persists.
    fail_on_error: ?bool = null,

    /// The format of the data. For more information about data formats for the
    /// Neptune `Loader` command, see [Load Data
    /// Formats](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format.html). **Allowed values**
    ///
    /// * ** `csv` ** for the [Gremlin CSV data
    ///   format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html).
    /// * ** `opencypher` ** for the [openCypher CSV data
    ///   format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html).
    /// * ** `ntriples` ** for the [N-Triples RDF data
    ///   format](https://www.w3.org/TR/n-triples/).
    /// * ** `nquads` ** for the [N-Quads RDF data
    ///   format](https://www.w3.org/TR/n-quads/).
    /// * ** `rdfxml` ** for the [RDF\XML RDF data
    ///   format](https://www.w3.org/TR/rdf-syntax-grammar/).
    /// * ** `turtle` ** for the [Turtle RDF data
    ///   format](https://www.w3.org/TR/turtle/).
    format: Format,

    /// The Amazon Resource Name (ARN) for an IAM role to be assumed by the Neptune
    /// DB instance for access to the S3 bucket. The IAM role ARN provided here
    /// should be attached to the DB cluster (see [Adding the IAM Role to an Amazon
    /// Neptune
    /// Cluster](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-IAM-add-role-cluster.html).
    iam_role_arn: []const u8,

    /// The load job mode.
    ///
    /// *Allowed values*: `RESUME`, `NEW`, `AUTO`.
    ///
    /// *Default value*: `AUTO`.
    ///
    /// * `RESUME` - In RESUME mode, the loader looks for a previous load from this
    ///   source, and if it finds one, resumes that load job. If no previous load
    ///   job is found, the loader stops.
    ///
    /// The loader avoids reloading files that were successfully loaded in a
    /// previous job. It only tries to process failed files. If you dropped
    /// previously loaded data from your Neptune cluster, that data is not reloaded
    /// in this mode. If a previous load job loaded all files from the same source
    /// successfully, nothing is reloaded, and the loader returns success.
    /// * `NEW` - In NEW mode, the creates a new load request regardless of any
    ///   previous loads. You can use this mode to reload all the data from a source
    ///   after dropping previously loaded data from your Neptune cluster, or to
    ///   load new data available at the same source.
    /// * `AUTO` - In AUTO mode, the loader looks for a previous load job from the
    ///   same source, and if it finds one, resumes that job, just as in `RESUME`
    ///   mode.
    ///
    /// If the loader doesn't find a previous load job from the same source, it
    /// loads all data from the source, just as in `NEW` mode.
    mode: ?Mode = null,

    /// The optional `parallelism` parameter can be set to reduce the number of
    /// threads used by the bulk load process.
    ///
    /// *Allowed values*:
    ///
    /// * `LOW` –   The number of threads used is the number of available vCPUs
    ///   divided by 8.
    /// * `MEDIUM` –   The number of threads used is the number of available vCPUs
    ///   divided by 2.
    /// * `HIGH` –   The number of threads used is the same as the number of
    ///   available vCPUs.
    /// * `OVERSUBSCRIBE` –   The number of threads used is the number of available
    ///   vCPUs multiplied by 2. If this value is used, the bulk loader takes up all
    ///   available resources.
    ///
    /// This does not mean, however, that the `OVERSUBSCRIBE` setting results in
    /// 100% CPU utilization. Because the load operation is I/O bound, the highest
    /// CPU utilization to expect is in the 60% to 70% range.
    ///
    /// *Default value*: `HIGH`
    ///
    /// The `parallelism` setting can sometimes result in a deadlock between threads
    /// when loading openCypher data. When this happens, Neptune returns the
    /// `LOAD_DATA_DEADLOCK` error. You can generally fix the issue by setting
    /// `parallelism` to a lower setting and retrying the load command.
    parallelism: ?Parallelism = null,

    /// ** `parserConfiguration` **   –   An optional object with additional parser
    /// configuration values. Each of the child parameters is also optional:
    ///
    /// * ** `namedGraphUri` ** - The default graph for all RDF formats when no
    ///   graph is specified (for non-quads formats and NQUAD entries with no
    ///   graph).
    ///
    /// The default is `https://aws.amazon.com/neptune/vocab/v01/DefaultNamedGraph`.
    /// * ** `baseUri` ** - The base URI for RDF/XML and Turtle formats.
    ///
    /// The default is `https://aws.amazon.com/neptune/default`.
    /// * ** `allowEmptyStrings` ** - Gremlin users need to be able to pass empty
    ///   string values("") as node and edge properties when loading CSV data. If
    ///   `allowEmptyStrings` is set to `false` (the default), such empty strings
    ///   are treated as nulls and are not loaded.
    ///
    /// If `allowEmptyStrings` is set to `true`, the loader treats empty strings as
    /// valid property values and loads them accordingly.
    parser_configuration: ?[]const aws.map.StringMapEntry = null,

    /// This is an optional flag parameter that indicates whether the load request
    /// can be queued up or not.
    ///
    /// You don't have to wait for one load job to complete before issuing the next
    /// one, because Neptune can queue up as many as 64 jobs at a time, provided
    /// that their `queueRequest` parameters are all set to `"TRUE"`. The queue
    /// order of the jobs will be first-in-first-out (FIFO).
    ///
    /// If the `queueRequest` parameter is omitted or set to `"FALSE"`, the load
    /// request will fail if another load job is already running.
    ///
    /// *Allowed values*: `"TRUE"`, `"FALSE"`.
    ///
    /// *Default value*: `"FALSE"`.
    queue_request: ?bool = null,

    /// The Amazon region of the S3 bucket. This must match the Amazon Region of the
    /// DB cluster.
    s_3_bucket_region: S3BucketRegion,

    /// The `source` parameter accepts an S3 URI that identifies a single file,
    /// multiple files, a folder, or multiple folders. Neptune loads every data file
    /// in any folder that is specified.
    ///
    /// The URI can be in any of the following formats.
    ///
    /// * `s3://(bucket_name)/(object-key-name)`
    /// * `https://s3.amazonaws.com/(bucket_name)/(object-key-name)`
    /// * `https://s3.us-east-1.amazonaws.com/(bucket_name)/(object-key-name)`
    ///
    /// The `object-key-name` element of the URI is equivalent to the
    /// [prefix](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html#API_ListObjects_RequestParameters) parameter in an S3 [ListObjects](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html) API call. It identifies all the objects in the specified S3 bucket whose names begin with that prefix. That can be a single file or folder, or multiple files and/or folders.
    ///
    /// The specified folder or folders can contain multiple vertex files and
    /// multiple edge files.
    source: []const u8,

    /// `updateSingleCardinalityProperties` is an optional parameter that controls
    /// how the bulk loader treats a new value for single-cardinality vertex or edge
    /// properties. This is not supported for loading openCypher data.
    ///
    /// *Allowed values*: `"TRUE"`, `"FALSE"`.
    ///
    /// *Default value*: `"FALSE"`.
    ///
    /// By default, or when `updateSingleCardinalityProperties` is explicitly set to
    /// `"FALSE"`, the loader treats a new value as an error, because it violates
    /// single cardinality.
    ///
    /// When `updateSingleCardinalityProperties` is set to `"TRUE"`, on the other
    /// hand, the bulk loader replaces the existing value with the new one. If
    /// multiple edge or single-cardinality vertex property values are provided in
    /// the source file(s) being loaded, the final value at the end of the bulk load
    /// could be any one of those new values. The loader only guarantees that the
    /// existing value has been replaced by one of the new ones.
    update_single_cardinality_properties: ?bool = null,

    /// This parameter is required only when loading openCypher data that contains
    /// relationship IDs. It must be included and set to `True` when openCypher
    /// relationship IDs are explicitly provided in the load data (recommended).
    ///
    /// When `userProvidedEdgeIds` is absent or set to `True`, an `:ID` column must
    /// be present in every relationship file in the load.
    ///
    /// When `userProvidedEdgeIds` is present and set to `False`, relationship files
    /// in the load **must not** contain an `:ID` column. Instead, the Neptune
    /// loader automatically generates an ID for each relationship.
    ///
    /// It's useful to provide relationship IDs explicitly so that the loader can
    /// resume loading after error in the CSV data have been fixed, without having
    /// to reload any relationships that have already been loaded. If relationship
    /// IDs have not been explicitly assigned, the loader cannot resume a failed
    /// load if any relationship file has had to be corrected, and must instead
    /// reload all the relationships.
    user_provided_edge_ids: ?bool = null,

    pub const json_field_names = .{
        .dependencies = "dependencies",
        .edge_only_load = "edgeOnlyLoad",
        .fail_on_error = "failOnError",
        .format = "format",
        .iam_role_arn = "iamRoleArn",
        .mode = "mode",
        .parallelism = "parallelism",
        .parser_configuration = "parserConfiguration",
        .queue_request = "queueRequest",
        .s_3_bucket_region = "s3BucketRegion",
        .source = "source",
        .update_single_cardinality_properties = "updateSingleCardinalityProperties",
        .user_provided_edge_ids = "userProvidedEdgeIds",
    };
};

pub const StartLoaderJobOutput = struct {
    /// Contains a `loadId` name-value pair that provides an identifier for the load
    /// operation.
    payload: ?[]const aws.map.StringMapEntry = null,

    /// The HTTP return code indicating the status of the load job.
    status: []const u8,

    pub const json_field_names = .{
        .payload = "payload",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartLoaderJobInput, options: CallOptions) !StartLoaderJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "neptune-db");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartLoaderJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/loader";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dependencies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dependencies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.edge_only_load) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"edgeOnlyLoad\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fail_on_error) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"failOnError\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"format\":");
    try aws.json.writeValue(@TypeOf(input.format), input.format, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"iamRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.iam_role_arn), input.iam_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parallelism) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parallelism\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parser_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parserConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.queue_request) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queueRequest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"s3BucketRegion\":");
    try aws.json.writeValue(@TypeOf(input.s_3_bucket_region), input.s_3_bucket_region, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;
    if (input.update_single_cardinality_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateSingleCardinalityProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_provided_edge_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userProvidedEdgeIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartLoaderJobOutput {
    var result: StartLoaderJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartLoaderJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BulkLoadIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .bulk_load_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CancelledByUserException")) {
        return .{ .arena = arena, .kind = .{ .cancelled_by_user_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .client_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConstraintViolationException")) {
        return .{ .arena = arena, .kind = .{ .constraint_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredStreamException")) {
        return .{ .arena = arena, .kind = .{ .expired_stream_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailureByQueryException")) {
        return .{ .arena = arena, .kind = .{ .failure_by_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalArgumentException")) {
        return .{ .arena = arena, .kind = .{ .illegal_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidNumericDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_numeric_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LoadUrlAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .load_url_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedQueryException")) {
        return .{ .arena = arena, .kind = .{ .malformed_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MemoryLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .memory_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MethodNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .method_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MLResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ml_resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParsingException")) {
        return .{ .arena = arena, .kind = .{ .parsing_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionsFailedException")) {
        return .{ .arena = arena, .kind = .{ .preconditions_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .query_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryLimitException")) {
        return .{ .arena = arena, .kind = .{ .query_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .query_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReadOnlyViolationException")) {
        return .{ .arena = arena, .kind = .{ .read_only_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3Exception")) {
        return .{ .arena = arena, .kind = .{ .s3_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerShutdownException")) {
        return .{ .arena = arena, .kind = .{ .server_shutdown_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StatisticsNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .statistics_not_available_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamRecordsNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stream_records_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TimeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .time_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
