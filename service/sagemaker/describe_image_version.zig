const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ImageVersionStatus = @import("image_version_status.zig").ImageVersionStatus;
const JobType = @import("job_type.zig").JobType;
const Processor = @import("processor.zig").Processor;
const VendorGuidance = @import("vendor_guidance.zig").VendorGuidance;

pub const DescribeImageVersionInput = struct {
    /// The alias of the image version.
    alias: ?[]const u8 = null,

    /// The name of the image.
    image_name: []const u8,

    /// The version of the image. If not specified, the latest version is described.
    version: ?i32 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .image_name = "ImageName",
        .version = "Version",
    };
};

pub const DescribeImageVersionOutput = struct {
    /// The registry path of the container image on which this image version is
    /// based.
    base_image: ?[]const u8 = null,

    /// The registry path of the container image that contains this image version.
    container_image: ?[]const u8 = null,

    /// When the version was created.
    creation_time: ?i64 = null,

    /// When a create or delete operation fails, the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// Indicates Horovod compatibility.
    horovod: ?bool = null,

    /// The ARN of the image the version is based on.
    image_arn: ?[]const u8 = null,

    /// The ARN of the version.
    image_version_arn: ?[]const u8 = null,

    /// The status of the version.
    image_version_status: ?ImageVersionStatus = null,

    /// Indicates SageMaker AI job type compatibility.
    ///
    /// * `TRAINING`: The image version is compatible with SageMaker AI training
    ///   jobs.
    /// * `INFERENCE`: The image version is compatible with SageMaker AI inference
    ///   jobs.
    /// * `NOTEBOOK_KERNEL`: The image version is compatible with SageMaker AI
    ///   notebook kernels.
    job_type: ?JobType = null,

    /// When the version was last modified.
    last_modified_time: ?i64 = null,

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

    /// The stability of the image version specified by the maintainer.
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

    /// The version number.
    version: ?i32 = null,

    pub const json_field_names = .{
        .base_image = "BaseImage",
        .container_image = "ContainerImage",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .horovod = "Horovod",
        .image_arn = "ImageArn",
        .image_version_arn = "ImageVersionArn",
        .image_version_status = "ImageVersionStatus",
        .job_type = "JobType",
        .last_modified_time = "LastModifiedTime",
        .ml_framework = "MLFramework",
        .processor = "Processor",
        .programming_lang = "ProgrammingLang",
        .release_notes = "ReleaseNotes",
        .vendor_guidance = "VendorGuidance",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeImageVersionInput, options: CallOptions) !DescribeImageVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeImageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeImageVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeImageVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeImageVersionOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
