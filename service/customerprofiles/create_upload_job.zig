const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ObjectTypeField = @import("object_type_field.zig").ObjectTypeField;

pub const CreateUploadJobInput = struct {
    /// The expiry duration for the profiles ingested with the job. If not provided,
    /// the system
    /// default of 2 weeks is used.
    data_expiry: ?i32 = null,

    /// The unique name of the upload job. Could be a file name to identify the
    /// upload
    /// job.
    display_name: []const u8,

    /// The unique name of the domain. Domain should be exists for the upload job to
    /// be created.
    domain_name: []const u8,

    /// The mapping between CSV Columns and Profile Object attributes. A map of the
    /// name and
    /// ObjectType field.
    fields: []const aws.map.MapEntry(ObjectTypeField),

    /// The unique key columns for de-duping the profiles used to map data to the
    /// profile.
    unique_key: []const u8,

    pub const json_field_names = .{
        .data_expiry = "DataExpiry",
        .display_name = "DisplayName",
        .domain_name = "DomainName",
        .fields = "Fields",
        .unique_key = "UniqueKey",
    };
};

pub const CreateUploadJobOutput = struct {
    /// The unique identifier for the created upload job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUploadJobInput, options: CallOptions) !CreateUploadJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUploadJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/upload-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_expiry) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataExpiry\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DisplayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Fields\":");
    try aws.json.writeValue(@TypeOf(input.fields), input.fields, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UniqueKey\":");
    try aws.json.writeValue(@TypeOf(input.unique_key), input.unique_key, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUploadJobOutput {
    var result: CreateUploadJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateUploadJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
