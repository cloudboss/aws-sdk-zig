const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoMerging = @import("auto_merging.zig").AutoMerging;
const ExportingLocation = @import("exporting_location.zig").ExportingLocation;
const JobStats = @import("job_stats.zig").JobStats;
const IdentityResolutionJobStatus = @import("identity_resolution_job_status.zig").IdentityResolutionJobStatus;

pub const GetIdentityResolutionJobInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The unique identifier of the Identity Resolution Job.
    job_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .job_id = "JobId",
    };
};

pub const GetIdentityResolutionJobOutput = struct {
    /// Configuration settings for how to perform the auto-merging of profiles.
    auto_merging: ?AutoMerging = null,

    /// The unique name of the domain.
    domain_name: ?[]const u8 = null,

    /// The S3 location where the Identity Resolution Job writes result files.
    exporting_location: ?ExportingLocation = null,

    /// The timestamp of when the Identity Resolution Job was completed.
    job_end_time: ?i64 = null,

    /// The timestamp of when the Identity Resolution Job will expire.
    job_expiration_time: ?i64 = null,

    /// The unique identifier of the Identity Resolution Job.
    job_id: ?[]const u8 = null,

    /// The timestamp of when the Identity Resolution Job was started or will be
    /// started.
    job_start_time: ?i64 = null,

    /// Statistics about the Identity Resolution Job.
    job_stats: ?JobStats = null,

    /// The timestamp of when the Identity Resolution Job was most recently edited.
    last_updated_at: ?i64 = null,

    /// The error messages that are generated when the Identity Resolution Job runs.
    message: ?[]const u8 = null,

    /// The status of the Identity Resolution Job.
    ///
    /// * `PENDING`: The Identity Resolution Job is scheduled but has not started
    ///   yet. If you turn
    /// off the Identity Resolution feature in your domain, jobs in the `PENDING`
    /// state are
    /// deleted.
    ///
    /// * `PREPROCESSING`: The Identity Resolution Job is loading your data.
    ///
    /// * `FIND_MATCHING`: The Identity Resolution Job is using the machine learning
    ///   model to
    /// identify profiles that belong to the same matching group.
    ///
    /// * `MERGING`: The Identity Resolution Job is merging duplicate profiles.
    ///
    /// * `COMPLETED`: The Identity Resolution Job completed successfully.
    ///
    /// * `PARTIAL_SUCCESS`: There's a system error and not all of the data is
    /// merged. The Identity Resolution Job writes a message indicating the source
    /// of the problem.
    ///
    /// * `FAILED`: The Identity Resolution Job did not merge any data. It writes a
    ///   message
    /// indicating the source of the problem.
    status: ?IdentityResolutionJobStatus = null,

    pub const json_field_names = .{
        .auto_merging = "AutoMerging",
        .domain_name = "DomainName",
        .exporting_location = "ExportingLocation",
        .job_end_time = "JobEndTime",
        .job_expiration_time = "JobExpirationTime",
        .job_id = "JobId",
        .job_start_time = "JobStartTime",
        .job_stats = "JobStats",
        .last_updated_at = "LastUpdatedAt",
        .message = "Message",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityResolutionJobInput, options: CallOptions) !GetIdentityResolutionJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityResolutionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/identity-resolution-jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityResolutionJobOutput {
    const result: GetIdentityResolutionJobOutput = try aws.json.parseJsonObject(
        GetIdentityResolutionJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
