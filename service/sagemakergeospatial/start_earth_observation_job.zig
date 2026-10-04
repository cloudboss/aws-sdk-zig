const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputConfigInput = @import("input_config_input.zig").InputConfigInput;
const JobConfigInput = @import("job_config_input.zig").JobConfigInput;
const InputConfigOutput = @import("input_config_output.zig").InputConfigOutput;
const EarthObservationJobStatus = @import("earth_observation_job_status.zig").EarthObservationJobStatus;

pub const StartEarthObservationJobInput = struct {
    /// A unique token that guarantees that the call to this API is idempotent.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// job.
    execution_role_arn: []const u8,

    /// Input configuration information for the Earth Observation job.
    input_config: InputConfigInput,

    /// An object containing information about the job configuration.
    job_config: JobConfigInput,

    /// The Key Management Service key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the Earth Observation job.
    name: []const u8,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .execution_role_arn = "ExecutionRoleArn",
        .input_config = "InputConfig",
        .job_config = "JobConfig",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const StartEarthObservationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the Earth Observation job.
    arn: []const u8,

    /// The creation time.
    creation_time: i64,

    /// The duration of the session, in seconds.
    duration_in_seconds: i32,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// job.
    execution_role_arn: []const u8,

    /// Input configuration information for the Earth Observation job.
    input_config: ?InputConfigOutput = null,

    /// An object containing information about the job configuration.
    job_config: ?JobConfigInput = null,

    /// The Key Management Service key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the Earth Observation job.
    name: []const u8,

    /// The status of the Earth Observation job.
    status: EarthObservationJobStatus,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .duration_in_seconds = "DurationInSeconds",
        .execution_role_arn = "ExecutionRoleArn",
        .input_config = "InputConfig",
        .job_config = "JobConfig",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEarthObservationJobInput, options: CallOptions) !StartEarthObservationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker-geospatial", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartEarthObservationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/earth-observation-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InputConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_config), input.input_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"JobConfig\":");
    try aws.json.writeValue(@TypeOf(input.job_config), input.job_config, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartEarthObservationJobOutput {
    var result: StartEarthObservationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartEarthObservationJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
