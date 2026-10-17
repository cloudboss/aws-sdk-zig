const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportDataType = @import("export_data_type.zig").ExportDataType;
const ExportDestination = @import("export_destination.zig").ExportDestination;
const ExportFailureCode = @import("export_failure_code.zig").ExportFailureCode;
const ExportOutput = @import("export_output.zig").ExportOutput;
const ExportScopes = @import("export_scopes.zig").ExportScopes;
const ExportStatus = @import("export_status.zig").ExportStatus;

pub const GetExportJobV2Input = struct {
    /// The unique identifier of the export job to retrieve. This is the value
    /// returned by `StartExportJobV2`.
    export_job_id: []const u8,

    pub const json_field_names = .{
        .export_job_id = "ExportJobId",
    };
};

pub const GetExportJobV2Output = struct {
    /// The category of data that the export job produces.
    data_type: ExportDataType,

    /// The destination that the export job writes to.
    destination: ?ExportDestination = null,

    /// The time when the export job reached a terminal state (`SUCCEEDED`,
    /// `FAILED`, or `CANCELLED`). This parameter is absent while the job is
    /// `RUNNING`.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    ended_at: ?i64 = null,

    /// The unique identifier of the export job.
    export_job_id: []const u8,

    /// A code that classifies why the export job failed. Present only when `Status`
    /// is `FAILED`.
    failure_code: ?ExportFailureCode = null,

    /// A human-readable message that provides more detail about why the export job
    /// failed. Present only when `Status` is `FAILED`.
    failure_message: ?[]const u8 = null,

    /// The user-provided name of the export job, if one was specified when the job
    /// was started.
    name: ?[]const u8 = null,

    /// The output configuration that the export job was started with, including the
    /// format and any filters or selected fields.
    output_configuration: ?ExportOutput = null,

    /// The organization scopes that the export job was started with, echoed
    /// verbatim. This parameter is absent if the caller didn't supply `Scopes`. It
    /// contains only the organization or organizational unit (OU) identifiers that
    /// the caller submitted; it never contains resolved member-account identifiers.
    scopes: ?ExportScopes = null,

    /// The time when the export job was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    started_at: i64,

    /// The current state of the export job.
    status: ExportStatus,

    pub const json_field_names = .{
        .data_type = "DataType",
        .destination = "Destination",
        .ended_at = "EndedAt",
        .export_job_id = "ExportJobId",
        .failure_code = "FailureCode",
        .failure_message = "FailureMessage",
        .name = "Name",
        .output_configuration = "OutputConfiguration",
        .scopes = "Scopes",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExportJobV2Input, options: CallOptions) !GetExportJobV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExportJobV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/exportjobsv2/");
    try path_buf.appendSlice(allocator, input.export_job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExportJobV2Output {
    const result: GetExportJobV2Output = try aws.json.parseJsonObject(
        GetExportJobV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
