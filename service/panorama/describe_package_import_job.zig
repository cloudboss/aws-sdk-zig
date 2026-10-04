const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageImportJobInputConfig = @import("package_import_job_input_config.zig").PackageImportJobInputConfig;
const JobResourceTags = @import("job_resource_tags.zig").JobResourceTags;
const PackageImportJobType = @import("package_import_job_type.zig").PackageImportJobType;
const PackageImportJobOutput = @import("package_import_job_output.zig").PackageImportJobOutput;
const PackageImportJobOutputConfig = @import("package_import_job_output_config.zig").PackageImportJobOutputConfig;
const PackageImportJobStatus = @import("package_import_job_status.zig").PackageImportJobStatus;

pub const DescribePackageImportJobInput = struct {
    /// The job's ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribePackageImportJobOutput = struct {
    /// The job's client token.
    client_token: ?[]const u8 = null,

    /// When the job was created.
    created_time: i64,

    /// The job's input config.
    input_config: ?PackageImportJobInputConfig = null,

    /// The job's ID.
    job_id: []const u8,

    /// The job's tags.
    job_tags: ?[]const JobResourceTags = null,

    /// The job's type.
    job_type: PackageImportJobType,

    /// When the job was updated.
    last_updated_time: i64,

    /// The job's output.
    output: ?PackageImportJobOutput = null,

    /// The job's output config.
    output_config: ?PackageImportJobOutputConfig = null,

    /// The job's status.
    status: PackageImportJobStatus,

    /// The job's status message.
    status_message: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .created_time = "CreatedTime",
        .input_config = "InputConfig",
        .job_id = "JobId",
        .job_tags = "JobTags",
        .job_type = "JobType",
        .last_updated_time = "LastUpdatedTime",
        .output = "Output",
        .output_config = "OutputConfig",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePackageImportJobInput, options: CallOptions) !DescribePackageImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePackageImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/import-jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePackageImportJobOutput {
    var result: DescribePackageImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribePackageImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
