const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportConfiguration = @import("import_configuration.zig").ImportConfiguration;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartDICOMImportJobInput = struct {
    /// A unique identifier for API idempotency.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that grants permission to
    /// access medical imaging resources.
    data_access_role_arn: []const u8,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The import configuration for the import job.
    import_configuration: ?ImportConfiguration = null,

    /// The account ID of the source S3 bucket owner.
    input_owner_account_id: ?[]const u8 = null,

    /// The input prefix path for the S3 bucket that contains the DICOM files to be
    /// imported.
    input_s3_uri: []const u8,

    /// The import job name.
    job_name: ?[]const u8 = null,

    /// The output prefix of the S3 bucket to upload the results of the DICOM import
    /// job.
    output_s3_uri: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data_access_role_arn = "dataAccessRoleArn",
        .datastore_id = "datastoreId",
        .import_configuration = "importConfiguration",
        .input_owner_account_id = "inputOwnerAccountId",
        .input_s3_uri = "inputS3Uri",
        .job_name = "jobName",
        .output_s3_uri = "outputS3Uri",
    };
};

pub const StartDICOMImportJobOutput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// The import job identifier.
    job_id: []const u8,

    /// The import job status.
    job_status: JobStatus,

    /// The timestamp when the import job was submitted.
    submitted_at: i64,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .job_id = "jobId",
        .job_status = "jobStatus",
        .submitted_at = "submittedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDICOMImportJobInput, options: CallOptions) !StartDICOMImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medical-imaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDICOMImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/startDICOMImportJob/datastore/");
    try path_buf.appendSlice(allocator, input.datastore_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataAccessRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.data_access_role_arn), input.data_access_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.import_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"importConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_owner_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputOwnerAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputS3Uri\":");
    try aws.json.writeValue(@TypeOf(input.input_s3_uri), input.input_s3_uri, allocator, &body_buf);
    has_prev = true;
    if (input.job_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputS3Uri\":");
    try aws.json.writeValue(@TypeOf(input.output_s3_uri), input.output_s3_uri, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDICOMImportJobOutput {
    const result: StartDICOMImportJobOutput = try aws.json.parseJsonObject(
        StartDICOMImportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
