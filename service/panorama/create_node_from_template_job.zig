const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobResourceTags = @import("job_resource_tags.zig").JobResourceTags;
const TemplateType = @import("template_type.zig").TemplateType;

pub const CreateNodeFromTemplateJobInput = struct {
    /// Tags for the job.
    job_tags: ?[]const JobResourceTags = null,

    /// A description for the node.
    node_description: ?[]const u8 = null,

    /// A name for the node.
    node_name: []const u8,

    /// An output package name for the node.
    output_package_name: []const u8,

    /// An output package version for the node.
    output_package_version: []const u8,

    /// Template parameters for the node.
    template_parameters: []const aws.map.StringMapEntry,

    /// The type of node.
    template_type: TemplateType,

    pub const json_field_names = .{
        .job_tags = "JobTags",
        .node_description = "NodeDescription",
        .node_name = "NodeName",
        .output_package_name = "OutputPackageName",
        .output_package_version = "OutputPackageVersion",
        .template_parameters = "TemplateParameters",
        .template_type = "TemplateType",
    };
};

pub const CreateNodeFromTemplateJobOutput = struct {
    /// The job's ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNodeFromTemplateJobInput, options: CallOptions) !CreateNodeFromTemplateJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNodeFromTemplateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/packages/template-job";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.job_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JobTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.node_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NodeDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"NodeName\":");
    try aws.json.writeValue(@TypeOf(input.node_name), input.node_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputPackageName\":");
    try aws.json.writeValue(@TypeOf(input.output_package_name), input.output_package_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputPackageVersion\":");
    try aws.json.writeValue(@TypeOf(input.output_package_version), input.output_package_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TemplateParameters\":");
    try aws.json.writeValue(@TypeOf(input.template_parameters), input.template_parameters, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TemplateType\":");
    try aws.json.writeValue(@TypeOf(input.template_type), input.template_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNodeFromTemplateJobOutput {
    var result: CreateNodeFromTemplateJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateNodeFromTemplateJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
