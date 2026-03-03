const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const JobType = @import("job_type.zig").JobType;
const Processor = @import("processor.zig").Processor;
const VendorGuidance = @import("vendor_guidance.zig").VendorGuidance;

pub const CreateImageVersionInput = struct {
    /// A list of aliases created with the image version.
    aliases: ?[]const []const u8 = null,

    /// The registry path of the container image to use as the starting point for
    /// this version. The path is an Amazon ECR URI in the following format:
    ///
    /// `<acct-id>.dkr.ecr.<region>.amazonaws.com/<repo-name[:tag] or [@digest]>`
    base_image: []const u8,

    /// A unique ID. If not specified, the Amazon Web Services CLI and Amazon Web
    /// Services SDKs, such as the SDK for Python (Boto3), add a unique value to the
    /// call.
    client_token: []const u8,

    /// Indicates Horovod compatibility.
    horovod: ?bool = null,

    /// The `ImageName` of the `Image` to create a version of.
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

    /// The stability of the image version, specified by the maintainer.
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

    pub const json_field_names = .{
        .aliases = "Aliases",
        .base_image = "BaseImage",
        .client_token = "ClientToken",
        .horovod = "Horovod",
        .image_name = "ImageName",
        .job_type = "JobType",
        .ml_framework = "MLFramework",
        .processor = "Processor",
        .programming_lang = "ProgrammingLang",
        .release_notes = "ReleaseNotes",
        .vendor_guidance = "VendorGuidance",
    };
};

pub const CreateImageVersionOutput = struct {
    /// The ARN of the image version.
    image_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_version_arn = "ImageVersionArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImageVersionInput, options: Options) !CreateImageVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateImageVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImageVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateImageVersionOutput, body, allocator);
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
