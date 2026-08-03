const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const JobType = @import("job_type.zig").JobType;
const Processor = @import("processor.zig").Processor;
const VendorGuidance = @import("vendor_guidance.zig").VendorGuidance;

pub const UpdateImageVersionInput = struct {
    /// The alias of the image version.
    alias: ?[]const u8 = null,

    /// A list of aliases to add.
    aliases_to_add: ?[]const []const u8 = null,

    /// A list of aliases to delete.
    aliases_to_delete: ?[]const []const u8 = null,

    /// Indicates Horovod compatibility.
    horovod: ?bool = null,

    /// The name of the image.
    image_name: []const u8,

    /// Indicates SageMaker AI job type compatibility.
    ///
    /// * `TRAINING`: The image version is compatible with SageMaker AI training
    ///   jobs.
    /// * `INFERENCE`: The image version is compatible with SageMaker AI inference
    ///   jobs.
    /// * `NOTEBOOK_KERNEL`: The image version is compatible with SageMaker AI
    ///   notebook kernels.
    job_type: ?JobType = null,

    /// The machine learning framework vended in the image version.
    ml_framework: ?[]const u8 = null,

    /// Indicates CPU or GPU compatibility.
    ///
    /// * `CPU`: The image version is compatible with CPU.
    /// * `GPU`: The image version is compatible with GPU.
    processor: ?Processor = null,

    /// The supported programming language and its version.
    programming_lang: ?[]const u8 = null,

    /// The maintainer description of the image version.
    release_notes: ?[]const u8 = null,

    /// The availability of the image version specified by the maintainer.
    ///
    /// * `NOT_PROVIDED`: The maintainers did not provide a status for image version
    ///   stability.
    /// * `STABLE`: The image version is stable.
    /// * `TO_BE_ARCHIVED`: The image version is set to be archived. Custom image
    ///   versions that are set to be archived are automatically archived after
    ///   three months.
    /// * `ARCHIVED`: The image version is archived. Archived image versions are not
    ///   searchable and are no longer actively supported.
    vendor_guidance: ?VendorGuidance = null,

    /// The version of the image.
    version: ?i32 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .aliases_to_add = "AliasesToAdd",
        .aliases_to_delete = "AliasesToDelete",
        .horovod = "Horovod",
        .image_name = "ImageName",
        .job_type = "JobType",
        .ml_framework = "MLFramework",
        .processor = "Processor",
        .programming_lang = "ProgrammingLang",
        .release_notes = "ReleaseNotes",
        .vendor_guidance = "VendorGuidance",
        .version = "Version",
    };
};

pub const UpdateImageVersionOutput = struct {
    /// The ARN of the image version.
    image_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_version_arn = "ImageVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateImageVersionInput, options: CallOptions) !UpdateImageVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateImageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateImageVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateImageVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateImageVersionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        const parsed_error: ?errors.ResourceInUse = aws.json.parseJsonObject(errors.ResourceInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        const parsed_error: ?errors.ResourceLimitExceeded = aws.json.parseJsonObject(errors.ResourceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?errors.ResourceNotFound = aws.json.parseJsonObject(errors.ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
