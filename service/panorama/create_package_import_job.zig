const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageImportJobInputConfig = @import("package_import_job_input_config.zig").PackageImportJobInputConfig;
const JobResourceTags = @import("job_resource_tags.zig").JobResourceTags;
const PackageImportJobType = @import("package_import_job_type.zig").PackageImportJobType;
const PackageImportJobOutputConfig = @import("package_import_job_output_config.zig").PackageImportJobOutputConfig;

pub const CreatePackageImportJobInput = struct {
    /// A client token for the package import job.
    client_token: []const u8,

    /// An input config for the package import job.
    input_config: PackageImportJobInputConfig,

    /// Tags for the package import job.
    job_tags: ?[]const JobResourceTags = null,

    /// A job type for the package import job.
    job_type: PackageImportJobType,

    /// An output config for the package import job.
    output_config: PackageImportJobOutputConfig,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .input_config = "InputConfig",
        .job_tags = "JobTags",
        .job_type = "JobType",
        .output_config = "OutputConfig",
    };
};

pub const CreatePackageImportJobOutput = struct {
    /// The job's ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePackageImportJobInput, options: CallOptions) !CreatePackageImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePackageImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/packages/import-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InputConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_config), input.input_config, allocator, &body_buf);
    has_prev = true;
    if (input.job_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JobTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"JobType\":");
    try aws.json.writeValue(@TypeOf(input.job_type), input.job_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_config), input.output_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePackageImportJobOutput {
    var result: CreatePackageImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePackageImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
