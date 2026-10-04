const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobTemplateData = @import("job_template_data.zig").JobTemplateData;

pub const CreateJobTemplateInput = struct {
    /// The client token of the job template.
    client_token: []const u8,

    /// The job template data which holds values of StartJobRun API request.
    job_template_data: JobTemplateData,

    /// The KMS key ARN used to encrypt the job template.
    kms_key_arn: ?[]const u8 = null,

    /// The specified name of the job template.
    name: []const u8,

    /// The tags that are associated with the job template.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .job_template_data = "jobTemplateData",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateJobTemplateOutput = struct {
    /// This output display the ARN of the created job template.
    arn: ?[]const u8 = null,

    /// This output displays the date and time when the job template was created.
    created_at: ?i64 = null,

    /// This output display the created job template ID.
    id: ?[]const u8 = null,

    /// This output displays the name of the created job template.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobTemplateInput, options: CallOptions) !CreateJobTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-containers", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/jobtemplates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobTemplateData\":");
    try aws.json.writeValue(@TypeOf(input.job_template_data), input.job_template_data, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobTemplateOutput {
    var result: CreateJobTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
