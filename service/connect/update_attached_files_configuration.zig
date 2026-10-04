const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentScope = @import("attachment_scope.zig").AttachmentScope;
const ExtensionConfiguration = @import("extension_configuration.zig").ExtensionConfiguration;

pub const UpdateAttachedFilesConfigurationInput = struct {
    /// The scope of the attachment. Valid values are `EMAIL`, `CHAT`, `CASE`, and
    /// `TASK`.
    attachment_scope: AttachmentScope,

    /// The configuration for allowed file extensions.
    extension_configuration: ?ExtensionConfiguration = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum size limit for attached files in bytes. The minimum value is 1
    /// and the maximum value is 104857600 (100 MB).
    maximum_size_limit_in_bytes: ?i64 = null,

    pub const json_field_names = .{
        .attachment_scope = "AttachmentScope",
        .extension_configuration = "ExtensionConfiguration",
        .instance_id = "InstanceId",
        .maximum_size_limit_in_bytes = "MaximumSizeLimitInBytes",
    };
};

pub const UpdateAttachedFilesConfigurationOutput = struct {
    /// The scope of the attachment.
    attachment_scope: AttachmentScope,

    /// The configuration for allowed file extensions.
    extension_configuration: ?ExtensionConfiguration = null,

    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The timestamp when the configuration was last modified.
    last_modified_time: ?i64 = null,

    /// The maximum size limit for attached files in bytes.
    maximum_size_limit_in_bytes: ?i64 = null,

    pub const json_field_names = .{
        .attachment_scope = "AttachmentScope",
        .extension_configuration = "ExtensionConfiguration",
        .instance_id = "InstanceId",
        .last_modified_time = "LastModifiedTime",
        .maximum_size_limit_in_bytes = "MaximumSizeLimitInBytes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAttachedFilesConfigurationInput, options: CallOptions) !UpdateAttachedFilesConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAttachedFilesConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attached-files-configurations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.attachment_scope);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.extension_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExtensionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_size_limit_in_bytes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumSizeLimitInBytes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAttachedFilesConfigurationOutput {
    var result: UpdateAttachedFilesConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAttachedFilesConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
