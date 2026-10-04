const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorReportLocation = @import("error_report_location.zig").ErrorReportLocation;
const File = @import("file.zig").File;
const JobConfiguration = @import("job_configuration.zig").JobConfiguration;
const JobStatus = @import("job_status.zig").JobStatus;

pub const CreateBulkImportJobInput = struct {
    /// If set to true, ingest new data into IoT SiteWise storage. Measurements with
    /// notifications, metrics and transforms are
    /// computed. If set to false, historical data is ingested into IoT SiteWise as
    /// is.
    adaptive_ingestion: ?bool = null,

    /// The ID of the session dataset to ingest data into. Specify this field,
    /// together with
    /// `workspaceName`, to ingest data into a session dataset in a workspace.
    dataset_id: ?[]const u8 = null,

    /// If set to true, your data files is deleted from S3, after ingestion into IoT
    /// SiteWise storage.
    delete_files_after_import: ?bool = null,

    /// The Amazon S3 destination where errors associated with the job creation
    /// request are saved.
    error_report_location: ErrorReportLocation,

    /// The files in the specified Amazon S3 bucket that contain your data. You can
    /// specify up to 100 files for each bulk import job. Each file supports the
    /// following size limits:
    ///
    /// * Parquet files – Up to 256 MiB.
    ///
    /// * Other file formats – Up to 5 GiB.
    files: []const File,

    /// Contains the configuration information of a job, such as the file format
    /// used to save data in Amazon S3.
    job_configuration: ?JobConfiguration = null,

    /// The unique name that helps identify the job request.
    job_name: []const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IAM role that allows IoT SiteWise to read Amazon S3 data.
    job_role_arn: []const u8,

    /// The name of the workspace that contains the session dataset. Specify this
    /// field together
    /// with `datasetId`.
    workspace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .adaptive_ingestion = "adaptiveIngestion",
        .dataset_id = "datasetId",
        .delete_files_after_import = "deleteFilesAfterImport",
        .error_report_location = "errorReportLocation",
        .files = "files",
        .job_configuration = "jobConfiguration",
        .job_name = "jobName",
        .job_role_arn = "jobRoleArn",
        .workspace_name = "workspaceName",
    };
};

pub const CreateBulkImportJobOutput = struct {
    /// The ID of the job.
    job_id: []const u8,

    /// The unique name that helps identify the job request.
    job_name: []const u8,

    /// The status of the bulk import job can be one of following values:
    ///
    /// * `PENDING` – IoT SiteWise is waiting for the current bulk import job to
    ///   finish.
    ///
    /// * `CANCELLED` – The bulk import job has been canceled.
    ///
    /// * `RUNNING` – IoT SiteWise is processing your request to import your data
    ///   from Amazon S3.
    ///
    /// * `COMPLETED` – IoT SiteWise successfully completed your request to import
    ///   data from Amazon S3.
    ///
    /// * `FAILED` – IoT SiteWise couldn't process your request to import data from
    ///   Amazon S3.
    /// You can use logs saved in the specified error report location in Amazon S3
    /// to troubleshoot issues.
    ///
    /// * `COMPLETED_WITH_FAILURES` – IoT SiteWise completed your request to import
    ///   data from Amazon S3 with errors.
    /// You can use logs saved in the specified error report location in Amazon S3
    /// to troubleshoot issues.
    job_status: JobStatus,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_name = "jobName",
        .job_status = "jobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBulkImportJobInput, options: CallOptions) !CreateBulkImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBulkImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.adaptive_ingestion) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"adaptiveIngestion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dataset_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datasetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.delete_files_after_import) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deleteFilesAfterImport\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"errorReportLocation\":");
    try aws.json.writeValue(@TypeOf(input.error_report_location), input.error_report_location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"files\":");
    try aws.json.writeValue(@TypeOf(input.files), input.files, allocator, &body_buf);
    has_prev = true;
    if (input.job_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.job_role_arn), input.job_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.workspace_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBulkImportJobOutput {
    const result: CreateBulkImportJobOutput = try aws.json.parseJsonObject(
        CreateBulkImportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
