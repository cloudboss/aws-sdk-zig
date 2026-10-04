const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExternalSourceConfiguration = @import("external_source_configuration.zig").ExternalSourceConfiguration;
const ImportJobType = @import("import_job_type.zig").ImportJobType;
const ImportJobData = @import("import_job_data.zig").ImportJobData;

pub const StartImportJobInput = struct {
    /// The tags used to organize, track, or control access for this resource.
    client_token: ?[]const u8 = null,

    /// The configuration information of the external source that the resource data
    /// are imported from.
    external_source_configuration: ?ExternalSourceConfiguration = null,

    /// The type of the import job.
    ///
    /// * For importing quick response resource, set the value to `QUICK_RESPONSES`.
    import_job_type: ImportJobType,

    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    ///
    /// * For importing Amazon Q in Connect quick responses, this should be a
    ///   `QUICK_RESPONSES` type knowledge base.
    knowledge_base_id: []const u8,

    /// The metadata fields of the imported Amazon Q in Connect resources.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// A pointer to the uploaded asset. This value is returned by
    /// [StartContentUpload](https://docs.aws.amazon.com/wisdom/latest/APIReference/API_StartContentUpload.html).
    upload_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .external_source_configuration = "externalSourceConfiguration",
        .import_job_type = "importJobType",
        .knowledge_base_id = "knowledgeBaseId",
        .metadata = "metadata",
        .upload_id = "uploadId",
    };
};

pub const StartImportJobOutput = struct {
    /// The import job.
    import_job: ?ImportJobData = null,

    pub const json_field_names = .{
        .import_job = "importJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportJobInput, options: CallOptions) !StartImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/importJobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.external_source_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"externalSourceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"importJobType\":");
    try aws.json.writeValue(@TypeOf(input.import_job_type), input.import_job_type, allocator, &body_buf);
    has_prev = true;
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"uploadId\":");
    try aws.json.writeValue(@TypeOf(input.upload_id), input.upload_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImportJobOutput {
    var result: StartImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartImportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
