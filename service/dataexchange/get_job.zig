const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssetConfiguration = @import("asset_configuration.zig").AssetConfiguration;
const ResponseDetails = @import("response_details.zig").ResponseDetails;
const JobError = @import("job_error.zig").JobError;
const State = @import("state.zig").State;
const Type = @import("type.zig").Type;

pub const GetJobInput = struct {
    /// The unique identifier for a job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetJobOutput = struct {
    /// The ARN for the job.
    arn: ?[]const u8 = null,

    /// The configuration for the asset, including tags applied to assets created by
    /// the job.
    asset_configuration: ?AssetConfiguration = null,

    /// The date and time that the job was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// Details about the job.
    details: ?ResponseDetails = null,

    /// The errors associated with jobs.
    errors: ?[]const JobError = null,

    /// The unique identifier for the job.
    id: ?[]const u8 = null,

    /// The state of the job.
    state: ?State = null,

    /// The job type.
    @"type": ?Type = null,

    /// The date and time that the job was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_configuration = "AssetConfiguration",
        .created_at = "CreatedAt",
        .details = "Details",
        .errors = "Errors",
        .id = "Id",
        .state = "State",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJobInput, options: CallOptions) !GetJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dataexchange", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

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
