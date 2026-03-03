const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LoggingConfigurationInput = @import("logging_configuration_input.zig").LoggingConfigurationInput;
const UpdateNetworkConfigurationInput = @import("update_network_configuration_input.zig").UpdateNetworkConfigurationInput;
const WebserverAccessMode = @import("webserver_access_mode.zig").WebserverAccessMode;
const WorkerReplacementStrategy = @import("worker_replacement_strategy.zig").WorkerReplacementStrategy;

pub const UpdateEnvironmentInput = struct {
    /// A list of key-value pairs containing the Apache Airflow configuration
    /// options you want to attach to your environment. For more information, see
    /// [Apache Airflow configuration
    /// options](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-env-variables.html).
    airflow_configuration_options: ?[]const aws.map.StringMapEntry = null,

    /// The Apache Airflow version for your environment. To upgrade your
    /// environment, specify a newer version of Apache Airflow supported by Amazon
    /// MWAA.
    ///
    /// Before you upgrade an environment, make sure your requirements, DAGs,
    /// plugins, and other resources used in your workflows are compatible with the
    /// new Apache Airflow version. For more information about updating
    /// your resources, see [Upgrading an Amazon MWAA
    /// environment](https://docs.aws.amazon.com/mwaa/latest/userguide/upgrading-environment.html).
    ///
    /// Valid values: `1.10.12`, `2.0.2`, `2.2.2`,
    /// `2.4.3`, `2.5.1`, `2.6.3`, `2.7.2`,
    /// `2.8.1`, `2.9.2`, `2.10.1`, and `2.10.3`.
    airflow_version: ?[]const u8 = null,

    /// The relative path to the DAGs folder on your Amazon S3 bucket. For example,
    /// `dags`. For more information, see [Adding or updating
    /// DAGs](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-folder.html).
    dag_s3_path: ?[]const u8 = null,

    /// The environment class type. Valid values: `mw1.micro`,
    /// `mw1.small`, `mw1.medium`, `mw1.large`,
    /// `mw1.xlarge`, and `mw1.2xlarge`. For more information, see
    /// [Amazon MWAA environment
    /// class](https://docs.aws.amazon.com/mwaa/latest/userguide/environment-class.html).
    environment_class: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the execution role in IAM that allows MWAA
    /// to access Amazon Web Services resources in your environment. For example,
    /// `arn:aws:iam::123456789:role/my-execution-role`. For more information, see
    /// [Amazon MWAA Execution
    /// role](https://docs.aws.amazon.com/mwaa/latest/userguide/mwaa-create-role.html).
    execution_role_arn: ?[]const u8 = null,

    /// The Apache Airflow log types to send to CloudWatch Logs.
    logging_configuration: ?LoggingConfigurationInput = null,

    /// The maximum number of web servers that you want to run in your environment.
    /// Amazon MWAA scales the number of Apache Airflow web servers up to the number
    /// you specify for `MaxWebservers`
    /// when you interact with your Apache Airflow environment using Apache Airflow
    /// REST API, or
    /// the Apache Airflow CLI. For example, in scenarios where your workload
    /// requires network calls to the Apache Airflow REST API with a high
    /// transaction-per-second (TPS)
    /// rate, Amazon MWAA will increase the number of web servers up to the number
    /// set in `MaxWebserers`. As TPS rates decrease
    /// Amazon MWAA disposes of the additional web servers, and scales down to the
    /// number set in `MinxWebserers`.
    ///
    /// Valid values: For environments larger than mw1.micro, accepts values from
    /// `2` to `5`. Defaults to `2` for all environment
    /// sizes except mw1.micro, which defaults to `1`.
    max_webservers: ?i32 = null,

    /// The maximum number of workers that you want to run in your environment. MWAA
    /// scales the number of Apache Airflow workers up to the number you specify in
    /// the `MaxWorkers` field. For example, `20`. When there are no more tasks
    /// running, and no more in the queue, MWAA disposes of the extra workers
    /// leaving the one worker that is included with your environment, or the number
    /// you specify in `MinWorkers`.
    max_workers: ?i32 = null,

    /// The minimum number of web servers that you want to run in your environment.
    /// Amazon MWAA scales the number of Apache Airflow web servers up to the number
    /// you specify for `MaxWebservers`
    /// when you interact with your Apache Airflow environment using Apache Airflow
    /// REST API, or
    /// the Apache Airflow CLI. As the transaction-per-second rate, and the network
    /// load, decrease,
    /// Amazon MWAA disposes of the additional web servers, and scales down to the
    /// number set in `MinxWebserers`.
    ///
    /// Valid values: For environments larger than mw1.micro, accepts values from
    /// `2` to `5`. Defaults to `2` for all environment
    /// sizes except mw1.micro, which defaults to `1`.
    min_webservers: ?i32 = null,

    /// The minimum number of workers that you want to run in your environment. MWAA
    /// scales the number of Apache Airflow workers up to the number you specify in
    /// the `MaxWorkers` field. When there are no more tasks running, and no more in
    /// the queue, MWAA disposes of the extra workers leaving the worker count you
    /// specify in the `MinWorkers` field. For example, `2`.
    min_workers: ?i32 = null,

    /// The name of your Amazon MWAA environment. For example, `MyMWAAEnvironment`.
    name: []const u8,

    /// The VPC networking components used to secure and enable network traffic
    /// between the Amazon Web Services resources for your environment. For more
    /// information, see [About networking on Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/networking-about.html).
    network_configuration: ?UpdateNetworkConfigurationInput = null,

    /// The version of the plugins.zip file on your Amazon S3 bucket. You must
    /// specify a version each time a `plugins.zip` file is updated. For more
    /// information, see [How S3 Versioning
    /// works](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html).
    plugins_s3_object_version: ?[]const u8 = null,

    /// The relative path to the `plugins.zip` file on your Amazon S3 bucket. For
    /// example, `plugins.zip`. If specified, then the plugins.zip version is
    /// required. For more information, see [Installing custom
    /// plugins](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-import-plugins.html).
    plugins_s3_path: ?[]const u8 = null,

    /// The version of the requirements.txt file on your Amazon S3 bucket. You must
    /// specify a version each time a `requirements.txt` file is updated. For more
    /// information, see [How S3 Versioning
    /// works](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html).
    requirements_s3_object_version: ?[]const u8 = null,

    /// The relative path to the `requirements.txt` file on your Amazon S3 bucket.
    /// For example, `requirements.txt`. If specified, then a file version is
    /// required. For more information, see [Installing Python
    /// dependencies](https://docs.aws.amazon.com/mwaa/latest/userguide/working-dags-dependencies.html).
    requirements_s3_path: ?[]const u8 = null,

    /// The number of Apache Airflow schedulers to run in your Amazon MWAA
    /// environment.
    schedulers: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket where your DAG code
    /// and supporting files are stored. For example,
    /// `arn:aws:s3:::my-airflow-bucket-unique-name`. For more information, see
    /// [Create an Amazon S3 bucket for Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/mwaa-s3-bucket.html).
    source_bucket_arn: ?[]const u8 = null,

    /// The version of the startup shell script in your Amazon S3 bucket. You must
    /// specify the [version
    /// ID](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html) that Amazon S3 assigns to the file
    /// every time you update the script.
    ///
    /// Version IDs are Unicode, UTF-8 encoded, URL-ready, opaque strings that are
    /// no more than 1,024 bytes long. The following is an example:
    ///
    /// `3sL4kqtJlcpXroDTDmJ+rmSpXd3dIbrHY+MTRCxf3vjVBH40Nr8X8gdRQBpUMLUo`
    ///
    /// For more information, see [Using a startup
    /// script](https://docs.aws.amazon.com/mwaa/latest/userguide/using-startup-script.html).
    startup_script_s3_object_version: ?[]const u8 = null,

    /// The relative path to the startup shell script in your Amazon S3 bucket. For
    /// example, `s3://mwaa-environment/startup.sh`.
    ///
    /// Amazon MWAA runs the script as your environment starts, and before running
    /// the Apache Airflow process.
    /// You can use this script to install dependencies, modify Apache Airflow
    /// configuration options, and set environment variables. For more information,
    /// see
    /// [Using a startup
    /// script](https://docs.aws.amazon.com/mwaa/latest/userguide/using-startup-script.html).
    startup_script_s3_path: ?[]const u8 = null,

    /// The Apache Airflow *Web server* access mode. For more information, see
    /// [Apache Airflow access
    /// modes](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-networking.html).
    webserver_access_mode: ?WebserverAccessMode = null,

    /// The day and time of the week in Coordinated Universal Time (UTC) 24-hour
    /// standard time to start weekly maintenance updates of your environment in the
    /// following format: `DAY:HH:MM`. For example: `TUE:03:30`. You can specify a
    /// start time in 30 minute increments only.
    weekly_maintenance_window_start: ?[]const u8 = null,

    /// The worker replacement strategy to use when updating the environment.
    ///
    /// You can select one of the following strategies:
    ///
    /// * **Forced -** Stops and replaces Apache Airflow workers without waiting for
    ///   tasks to
    /// complete before an update.
    ///
    /// * **Graceful -** Allows Apache Airflow workers to complete running tasks for
    ///   up to 12 hours during an update before
    /// they're stopped and replaced.
    worker_replacement_strategy: ?WorkerReplacementStrategy = null,

    pub const json_field_names = .{
        .airflow_configuration_options = "AirflowConfigurationOptions",
        .airflow_version = "AirflowVersion",
        .dag_s3_path = "DagS3Path",
        .environment_class = "EnvironmentClass",
        .execution_role_arn = "ExecutionRoleArn",
        .logging_configuration = "LoggingConfiguration",
        .max_webservers = "MaxWebservers",
        .max_workers = "MaxWorkers",
        .min_webservers = "MinWebservers",
        .min_workers = "MinWorkers",
        .name = "Name",
        .network_configuration = "NetworkConfiguration",
        .plugins_s3_object_version = "PluginsS3ObjectVersion",
        .plugins_s3_path = "PluginsS3Path",
        .requirements_s3_object_version = "RequirementsS3ObjectVersion",
        .requirements_s3_path = "RequirementsS3Path",
        .schedulers = "Schedulers",
        .source_bucket_arn = "SourceBucketArn",
        .startup_script_s3_object_version = "StartupScriptS3ObjectVersion",
        .startup_script_s3_path = "StartupScriptS3Path",
        .webserver_access_mode = "WebserverAccessMode",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
        .worker_replacement_strategy = "WorkerReplacementStrategy",
    };
};

pub const UpdateEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon MWAA environment. For example,
    /// `arn:aws:airflow:us-east-1:123456789012:environment/MyMWAAEnvironment`.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentInput, options: Options) !UpdateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mwaa");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mwaa", "MWAA", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.airflow_configuration_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AirflowConfigurationOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.airflow_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AirflowVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dag_s3_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DagS3Path\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_class) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EnvironmentClass\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExecutionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoggingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_webservers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxWebservers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_workers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxWorkers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_webservers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinWebservers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_workers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinWorkers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NetworkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.plugins_s3_object_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PluginsS3ObjectVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.plugins_s3_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PluginsS3Path\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requirements_s3_object_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequirementsS3ObjectVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requirements_s3_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequirementsS3Path\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.schedulers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Schedulers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_bucket_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceBucketArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.startup_script_s3_object_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartupScriptS3ObjectVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.startup_script_s3_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartupScriptS3Path\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.webserver_access_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WebserverAccessMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.weekly_maintenance_window_start) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WeeklyMaintenanceWindowStart\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.worker_replacement_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WorkerReplacementStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentOutput {
    var result: UpdateEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEnvironmentOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "RestApiClientException")) {
        return .{ .arena = arena, .kind = .{ .rest_api_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RestApiServerException")) {
        return .{ .arena = arena, .kind = .{ .rest_api_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
