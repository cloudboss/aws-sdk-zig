const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const S3Location = @import("s3_location.zig").S3Location;
const Tag = @import("tag.zig").Tag;
const Build = @import("build.zig").Build;
const AwsCredentials = @import("aws_credentials.zig").AwsCredentials;

pub const CreateBuildInput = struct {
    /// A descriptive label that is associated with a build. Build names do not need
    /// to be unique. You can change this value later.
    name: ?[]const u8 = null,

    /// The operating system that your game server binaries run on. This value
    /// determines the
    /// type of fleet resources that you use for this build. If your game build
    /// contains
    /// multiple executables, they all must run on the same operating system. You
    /// must specify a
    /// valid operating system in this request. There is no default value. You can't
    /// change a
    /// build's operating system later.
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in
    /// the [Amazon Linux 2 FAQs](http://aws.amazon.com/amazon-linux-2/faqs/).
    /// For game servers
    /// that are hosted on AL2 and use server SDK version 4.x for Amazon GameLift
    /// Servers, first update the
    /// game server build to server SDK 5.x, and then deploy to AL2023 instances.
    /// See
    /// [
    /// Migrate to server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    ///
    /// Windows Server 2016 will reach end of support on 1/12/2027.
    /// For game servers
    /// that are hosted on Windows Server 2016 and use server SDK version 4.x for
    /// Amazon GameLift Servers, first update the
    /// game server build to server SDK 5.x, and then deploy to Windows Server 2022
    /// instances. See
    /// [
    /// Migrate to server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ?OperatingSystem = null,

    /// A server SDK version you used when integrating your game server build with
    /// Amazon GameLift Servers. For more information see [Integrate games
    /// with custom game
    /// servers](https://docs.aws.amazon.com/gamelift/latest/developerguide/integration-custom-intro.html). By default Amazon GameLift Servers sets this value to
    /// `4.0.2`.
    server_sdk_version: ?[]const u8 = null,

    /// Information indicating where your game build files are stored. Use this
    /// parameter only
    /// when creating a build with files stored in an Amazon S3 bucket that you own.
    /// The storage
    /// location must specify an Amazon S3 bucket name and key. The location must
    /// also specify a role
    /// ARN that you set up to allow Amazon GameLift Servers to access your Amazon
    /// S3 bucket. The S3 bucket and your
    /// new build must be in the same Region.
    ///
    /// If a `StorageLocation` is specified, the size of your file can be found in
    /// your Amazon S3 bucket. Amazon GameLift Servers will report a `SizeOnDisk` of
    /// 0.
    storage_location: ?S3Location = null,

    /// A list of labels to assign to the new build resource. Tags are developer
    /// defined
    /// key-value pairs. Tagging Amazon Web Services resources are useful for
    /// resource management, access
    /// management and cost allocation. For more information, see [ Tagging Amazon
    /// Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the
    /// *Amazon Web Services General Reference*. Once the resource is created, you
    /// can
    /// use
    /// [TagResource](https://docs.aws.amazon.com/gamelift/latest/apireference/API_TagResource.html), [UntagResource](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UntagResource.html), and
    /// [ListTagsForResource](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ListTagsForResource.html) to add, remove, and view tags. The maximum tag limit
    /// may be lower than stated. See the Amazon Web Services General Reference for
    /// actual tagging
    /// limits.
    tags: ?[]const Tag = null,

    /// Version information that is associated with a build or script. Version
    /// strings do not need to be unique. You can change this value later.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .operating_system = "OperatingSystem",
        .server_sdk_version = "ServerSdkVersion",
        .storage_location = "StorageLocation",
        .tags = "Tags",
        .version = "Version",
    };
};

pub const CreateBuildOutput = struct {
    /// The newly created build resource, including a unique build IDs and status.
    build: ?Build = null,

    /// Amazon S3 location for your game build file, including bucket name and key.
    storage_location: ?S3Location = null,

    /// This element is returned only when the operation is called without a storage
    /// location.
    /// It contains credentials to use when you are uploading a build file to an
    /// Amazon S3 bucket
    /// that is owned by Amazon GameLift Servers. Credentials have a limited life
    /// span. To refresh these
    /// credentials, call
    /// [RequestUploadCredentials](https://docs.aws.amazon.com/gamelift/latest/apireference/API_RequestUploadCredentials.html).
    upload_credentials: ?AwsCredentials = null,

    pub const json_field_names = .{
        .build = "Build",
        .storage_location = "StorageLocation",
        .upload_credentials = "UploadCredentials",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBuildInput, options: CallOptions) !CreateBuildOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gamelift");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBuildInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateBuild");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBuildOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateBuildOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "FleetCapacityExceededException")) {
        return .{ .arena = arena, .kind = .{ .fleet_capacity_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GameSessionFullException")) {
        return .{ .arena = arena, .kind = .{ .game_session_full_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFleetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_fleet_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGameSessionStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_game_session_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotReadyException")) {
        return .{ .arena = arena, .kind = .{ .not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutOfCapacityException")) {
        return .{ .arena = arena, .kind = .{ .out_of_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaggingFailedException")) {
        return .{ .arena = arena, .kind = .{ .tagging_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TerminalRoutingStrategyException")) {
        return .{ .arena = arena, .kind = .{ .terminal_routing_strategy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedRegionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_region_exception = .{
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
