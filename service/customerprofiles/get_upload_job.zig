const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObjectTypeField = @import("object_type_field.zig").ObjectTypeField;
const ResultsSummary = @import("results_summary.zig").ResultsSummary;
const UploadJobStatus = @import("upload_job_status.zig").UploadJobStatus;
const StatusReason = @import("status_reason.zig").StatusReason;

pub const GetUploadJobInput = struct {
    /// The unique name of the domain containing the upload job.
    domain_name: []const u8,

    /// The unique identifier of the upload job to retrieve.
    job_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .job_id = "JobId",
    };
};

pub const GetUploadJobOutput = struct {
    /// The timestamp when the upload job was completed.
    completed_at: ?i64 = null,

    /// The timestamp when the upload job was created.
    created_at: ?i64 = null,

    /// The expiry duration for the profiles ingested with the upload job.
    data_expiry: ?i32 = null,

    /// The unique name of the upload job. Could be a file name to identify the
    /// upload job.
    display_name: ?[]const u8 = null,

    /// The mapping between CSV Columns and Profile Object attributes for the upload
    /// job.
    fields: ?[]const aws.map.MapEntry(ObjectTypeField) = null,

    /// The unique identifier of the upload job.
    job_id: ?[]const u8 = null,

    /// The summary of results for the upload job, including the number of updated,
    /// created, and
    /// failed records.
    results_summary: ?ResultsSummary = null,

    /// The status describing the status for the upload job. The following are Valid
    /// Values:
    ///
    /// * **CREATED**: The upload job has been created, but has
    /// not started processing yet.
    ///
    /// * **IN_PROGRESS**: The upload job is currently in
    /// progress, ingesting and processing the profile data.
    ///
    /// * **PARTIALLY_SUCCEEDED**: The upload job has
    /// successfully completed the ingestion and processing of all profile data.
    ///
    /// * **SUCCEEDED**: The upload job has successfully
    /// completed the ingestion and processing of all profile data.
    ///
    /// * **FAILED**: The upload job has failed to complete.
    ///
    /// * **STOPPED**: The upload job has been manually stopped
    /// or terminated before completion.
    status: ?UploadJobStatus = null,

    /// The reason for the current status of the upload job. Possible reasons:
    ///
    /// * **VALIDATION_FAILURE**: The upload job has
    /// encountered an error or issue and was unable to complete the profile data
    /// ingestion.
    ///
    /// * **INTERNAL_FAILURE**: Failure caused from service
    /// side
    status_reason: ?StatusReason = null,

    /// The unique key columns used for de-duping the keys in the upload job.
    unique_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_at = "CompletedAt",
        .created_at = "CreatedAt",
        .data_expiry = "DataExpiry",
        .display_name = "DisplayName",
        .fields = "Fields",
        .job_id = "JobId",
        .results_summary = "ResultsSummary",
        .status = "Status",
        .status_reason = "StatusReason",
        .unique_key = "UniqueKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUploadJobInput, options: CallOptions) !GetUploadJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUploadJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/upload-jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUploadJobOutput {
    const result: GetUploadJobOutput = try aws.json.parseJsonObject(
        GetUploadJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
