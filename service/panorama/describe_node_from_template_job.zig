const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobResourceTags = @import("job_resource_tags.zig").JobResourceTags;
const NodeFromTemplateJobStatus = @import("node_from_template_job_status.zig").NodeFromTemplateJobStatus;
const TemplateType = @import("template_type.zig").TemplateType;

pub const DescribeNodeFromTemplateJobInput = struct {
    /// The job's ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribeNodeFromTemplateJobOutput = struct {
    /// When the job was created.
    created_time: i64,

    /// The job's ID.
    job_id: []const u8,

    /// The job's tags.
    job_tags: ?[]const JobResourceTags = null,

    /// When the job was updated.
    last_updated_time: i64,

    /// The node's description.
    node_description: ?[]const u8 = null,

    /// The node's name.
    node_name: []const u8,

    /// The job's output package name.
    output_package_name: []const u8,

    /// The job's output package version.
    output_package_version: []const u8,

    /// The job's status.
    status: NodeFromTemplateJobStatus,

    /// The job's status message.
    status_message: []const u8,

    /// The job's template parameters.
    template_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The job's template type.
    template_type: TemplateType,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .job_id = "JobId",
        .job_tags = "JobTags",
        .last_updated_time = "LastUpdatedTime",
        .node_description = "NodeDescription",
        .node_name = "NodeName",
        .output_package_name = "OutputPackageName",
        .output_package_version = "OutputPackageVersion",
        .status = "Status",
        .status_message = "StatusMessage",
        .template_parameters = "TemplateParameters",
        .template_type = "TemplateType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNodeFromTemplateJobInput, options: CallOptions) !DescribeNodeFromTemplateJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNodeFromTemplateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packages/template-job/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNodeFromTemplateJobOutput {
    var result: DescribeNodeFromTemplateJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeNodeFromTemplateJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
