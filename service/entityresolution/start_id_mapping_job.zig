const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobType = @import("job_type.zig").JobType;
const IdMappingJobOutputSource = @import("id_mapping_job_output_source.zig").IdMappingJobOutputSource;

pub const StartIdMappingJobInput = struct {
    /// The job type for the ID mapping job.
    ///
    /// If the `jobType` value is set to `INCREMENTAL`, only new or changed data is
    /// processed since the last job run. This is the default value if the
    /// `CreateIdMappingWorkflow` API is configured with an `incrementalRunConfig`.
    ///
    /// If the `jobType` value is set to `BATCH`, all data is processed from the
    /// input source, regardless of previous job runs. This is the default value if
    /// the `CreateIdMappingWorkflow` API isn't configured with an
    /// `incrementalRunConfig`.
    ///
    /// If the `jobType` value is set to `DELETE_ONLY`, only deletion requests from
    /// `BatchDeleteUniqueIds` are processed.
    job_type: ?JobType = null,

    /// A list of `OutputSource` objects.
    output_source_config: ?[]const IdMappingJobOutputSource = null,

    /// The name of the ID mapping job to be retrieved.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .job_type = "jobType",
        .output_source_config = "outputSourceConfig",
        .workflow_name = "workflowName",
    };
};

pub const StartIdMappingJobOutput = struct {
    /// The ID of the job.
    job_id: []const u8,

    /// The job type for the started ID mapping job.
    ///
    /// A value of `INCREMENTAL` indicates that only new or changed data was
    /// processed since the last job run. This is the default job type if the
    /// workflow was created with an `incrementalRunConfig`.
    ///
    /// A value of `BATCH` indicates that all data was processed from the input
    /// source, regardless of previous job runs. This is the default job type if the
    /// workflow wasn't created with an `incrementalRunConfig`.
    ///
    /// A value of `DELETE_ONLY` indicates that only deletion requests from
    /// `BatchDeleteUniqueIds` were processed.
    job_type: ?JobType = null,

    /// A list of `OutputSource` objects.
    output_source_config: ?[]const IdMappingJobOutputSource = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_type = "jobType",
        .output_source_config = "outputSourceConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartIdMappingJobInput, options: CallOptions) !StartIdMappingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartIdMappingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/idmappingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    try path_buf.appendSlice(allocator, "/jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.job_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputSourceConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartIdMappingJobOutput {
    const result: StartIdMappingJobOutput = try aws.json.parseJsonObject(
        StartIdMappingJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
