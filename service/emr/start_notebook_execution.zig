const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExecutionEngineConfig = @import("execution_engine_config.zig").ExecutionEngineConfig;
const NotebookS3LocationFromInput = @import("notebook_s3_location_from_input.zig").NotebookS3LocationFromInput;
const OutputNotebookFormat = @import("output_notebook_format.zig").OutputNotebookFormat;
const OutputNotebookS3LocationFromInput = @import("output_notebook_s3_location_from_input.zig").OutputNotebookS3LocationFromInput;
const Tag = @import("tag.zig").Tag;

pub const StartNotebookExecutionInput = struct {
    /// The unique identifier of the Amazon EMR Notebook to use for notebook
    /// execution.
    editor_id: ?[]const u8 = null,

    /// The environment variables associated with the notebook execution.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the execution engine (cluster) that runs the notebook execution.
    execution_engine: ExecutionEngineConfig,

    /// An optional name for the notebook execution.
    notebook_execution_name: ?[]const u8 = null,

    /// The unique identifier of the Amazon EC2 security group to associate with the
    /// Amazon EMR Notebook for this notebook execution.
    notebook_instance_security_group_id: ?[]const u8 = null,

    /// Input parameters in JSON format passed to the Amazon EMR Notebook at runtime
    /// for
    /// execution.
    notebook_params: ?[]const u8 = null,

    /// The Amazon S3 location for the notebook execution input.
    notebook_s3_location: ?NotebookS3LocationFromInput = null,

    /// The output format for the notebook execution.
    output_notebook_format: ?OutputNotebookFormat = null,

    /// The Amazon S3 location for the notebook execution output.
    output_notebook_s3_location: ?OutputNotebookS3LocationFromInput = null,

    /// The path and file name of the notebook file for this execution, relative to
    /// the path
    /// specified for the Amazon EMR Notebook. For example, if you specify a path of
    /// `s3://MyBucket/MyNotebooks` when you create an Amazon EMR Notebook
    /// for a notebook with an ID of `e-ABCDEFGHIJK1234567890ABCD` (the
    /// `EditorID` of this request), and you specify a `RelativePath` of
    /// `my_notebook_executions/notebook_execution.ipynb`, the location of the file
    /// for the notebook execution is
    /// `s3://MyBucket/MyNotebooks/e-ABCDEFGHIJK1234567890ABCD/my_notebook_executions/notebook_execution.ipynb`.
    relative_path: ?[]const u8 = null,

    /// The name or ARN of the IAM role that is used as the service role for
    /// Amazon EMR (the Amazon EMR role) for the notebook execution.
    service_role: []const u8,

    /// A list of tags associated with a notebook execution. Tags are user-defined
    /// key-value
    /// pairs that consist of a required key string with a maximum of 128 characters
    /// and an
    /// optional value string with a maximum of 256 characters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .editor_id = "EditorId",
        .environment_variables = "EnvironmentVariables",
        .execution_engine = "ExecutionEngine",
        .notebook_execution_name = "NotebookExecutionName",
        .notebook_instance_security_group_id = "NotebookInstanceSecurityGroupId",
        .notebook_params = "NotebookParams",
        .notebook_s3_location = "NotebookS3Location",
        .output_notebook_format = "OutputNotebookFormat",
        .output_notebook_s3_location = "OutputNotebookS3Location",
        .relative_path = "RelativePath",
        .service_role = "ServiceRole",
        .tags = "Tags",
    };
};

pub const StartNotebookExecutionOutput = struct {
    /// The unique identifier of the notebook execution.
    notebook_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .notebook_execution_id = "NotebookExecutionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartNotebookExecutionInput, options: Options) !StartNotebookExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "emr");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartNotebookExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr", "EMR", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "ElasticMapReduce.StartNotebookExecution");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartNotebookExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartNotebookExecutionOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
