const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const S3Location = @import("s3_location.zig").S3Location;
const Tag = @import("tag.zig").Tag;
const Script = @import("script.zig").Script;

pub const CreateScriptInput = struct {
    /// A descriptive label that is associated with a script. Script names do not
    /// need to be unique. You can use
    /// [UpdateScript](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateScript.html) to
    /// change this value later.
    name: ?[]const u8 = null,

    /// The Node.js version used for execution of your Realtime script. The valid
    /// values are
    /// `10.x | 24.x`. By default, `NodeJsVersion` is `10.x`.
    /// This value cannot be updated later.
    node_js_version: ?[]const u8 = null,

    /// The location of the Amazon S3 bucket where a zipped file containing your
    /// Realtime scripts is
    /// stored. The storage location must specify the Amazon S3 bucket name, the zip
    /// file name (the
    /// "key"), and a role ARN that allows Amazon GameLift Servers to access the
    /// Amazon S3 storage location. The S3
    /// bucket must be in the same Region where you want to create a new script. By
    /// default,
    /// Amazon GameLift Servers uploads the latest version of the zip file; if you
    /// have S3 object versioning
    /// turned on, you can use the `ObjectVersion` parameter to specify an earlier
    /// version.
    storage_location: ?S3Location = null,

    /// A list of labels to assign to the new script resource. Tags are
    /// developer-defined
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
    /// strings do not need to be unique. You can use
    /// [UpdateScript](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateScript.html) to
    /// change this value later.
    version: ?[]const u8 = null,

    /// A data object containing your Realtime scripts and dependencies as a zip
    /// file. The zip
    /// file can have one or multiple files. Maximum size of a zip file is 5 MB.
    ///
    /// When using the Amazon Web Services CLI tool to create a script, this
    /// parameter is set to the zip
    /// file name. It must be prepended with the string "fileb://" to indicate that
    /// the file
    /// data is a binary object. For example: `--zip-file
    /// fileb://myRealtimeScript.zip`.
    zip_file: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .node_js_version = "NodeJsVersion",
        .storage_location = "StorageLocation",
        .tags = "Tags",
        .version = "Version",
        .zip_file = "ZipFile",
    };
};

pub const CreateScriptOutput = struct {
    /// The newly created script record with a unique script ID and ARN. The new
    /// script's
    /// storage location reflects an Amazon S3 location: (1) If the script was
    /// uploaded from an S3
    /// bucket under your account, the storage location reflects the information
    /// that was
    /// provided in the *CreateScript* request; (2) If the script file was
    /// uploaded from a local zip file, the storage location reflects an S3 location
    /// controls by
    /// the Amazon GameLift Servers service.
    script: ?Script = null,

    pub const json_field_names = .{
        .script = "Script",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScriptInput, options: Options) !CreateScriptOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateScriptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "GameLift.CreateScript");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateScriptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateScriptOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
