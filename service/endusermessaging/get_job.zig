const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobResource = @import("job_resource.zig").JobResource;
const JobStatus = @import("job_status.zig").JobStatus;

pub const GetJobInput = struct {
    /// The unique identifier of the asynchronous job. Use the GetJob operation to
    /// check the status of the job and to retrieve its results.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};

pub const GetJobOutput = struct {
    /// The brand profile that the job operates on. This value is absent for
    /// operations that create a brand profile.
    brand_profile_id: ?[]const u8 = null,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// A machine-readable code that identifies why the job failed. This value is
    /// present only when the job status is FAILED.
    error_code: ?[]const u8 = null,

    /// A human-readable description of why the job failed. This value is present
    /// only when the job status is FAILED.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the asynchronous job. Use the GetJob operation to
    /// check the status of the job and to retrieve its results.
    job_id: []const u8,

    /// The type of mutating operation that created the job.
    operation_type: []const u8,

    /// The resources that were created or updated by the job.
    resources: ?[]const JobResource = null,

    /// The current lifecycle status of the job.
    status: JobStatus,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .brand_profile_id = "brandProfileId",
        .created_at = "createdAt",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .job_id = "jobId",
        .operation_type = "operationType",
        .resources = "resources",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobInput, options: CallOptions) !GetJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJobOutput {
    const result: GetJobOutput = try aws.json.parseJsonObject(
        GetJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
