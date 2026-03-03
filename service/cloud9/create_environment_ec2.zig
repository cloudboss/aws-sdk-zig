const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const Tag = @import("tag.zig").Tag;

pub const CreateEnvironmentEC2Input = struct {
    /// The number of minutes until the running instance is shut down after the
    /// environment has
    /// last been used.
    automatic_stop_time_minutes: ?i32 = null,

    /// A unique, case-sensitive string that helps Cloud9 to ensure this operation
    /// completes no
    /// more than one time.
    ///
    /// For more information, see [Client
    /// Tokens](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html) in the
    /// *Amazon EC2 API Reference*.
    client_request_token: ?[]const u8 = null,

    /// The connection type used for connecting to an Amazon EC2 environment. Valid
    /// values are
    /// `CONNECT_SSH` (default) and `CONNECT_SSM` (connected through
    /// Amazon EC2 Systems Manager).
    ///
    /// For more information, see [Accessing no-ingress EC2 instances with
    /// Amazon EC2 Systems
    /// Manager](https://docs.aws.amazon.com/cloud9/latest/user-guide/ec2-ssm.html)
    /// in the *Cloud9 User Guide*.
    connection_type: ?ConnectionType = null,

    /// The description of the environment to create.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The identifier for the Amazon Machine Image (AMI) that's used to create the
    /// EC2 instance.
    /// To choose an AMI for the instance, you must specify a valid AMI alias or a
    /// valid Amazon EC2 Systems Manager (SSM)
    /// path.
    ///
    /// We recommend using Amazon Linux 2023 as the AMI to create your environment
    /// as it is fully
    /// supported.
    ///
    /// From December 16, 2024, Ubuntu 18.04 will be removed from the list of
    /// available
    /// `imageIds` for Cloud9. This change is necessary as Ubuntu 18.04 has ended
    /// standard
    /// support on May 31, 2023. This change will only affect direct API consumers,
    /// and not Cloud9
    /// console users.
    ///
    /// Since Ubuntu 18.04 has ended standard support as of May 31, 2023, we
    /// recommend you choose
    /// Ubuntu 22.04.
    ///
    /// **AMI aliases **
    ///
    /// * Amazon Linux 2: `amazonlinux-2-x86_64`
    ///
    /// * Amazon Linux 2023 (recommended): `amazonlinux-2023-x86_64`
    ///
    /// * Ubuntu 18.04: `ubuntu-18.04-x86_64`
    ///
    /// * Ubuntu 22.04: `ubuntu-22.04-x86_64`
    ///
    /// **SSM paths**
    ///
    /// * Amazon Linux 2:
    /// `resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2-x86_64`
    ///
    /// * Amazon Linux 2023 (recommended):
    /// `resolve:ssm:/aws/service/cloud9/amis/amazonlinux-2023-x86_64`
    ///
    /// * Ubuntu 18.04:
    /// `resolve:ssm:/aws/service/cloud9/amis/ubuntu-18.04-x86_64`
    ///
    /// * Ubuntu 22.04:
    /// `resolve:ssm:/aws/service/cloud9/amis/ubuntu-22.04-x86_64`
    image_id: []const u8,

    /// The type of instance to connect to the environment (for example,
    /// `t2.micro`).
    instance_type: []const u8,

    /// The name of the environment to create.
    ///
    /// This name is visible to other IAM users in the same Amazon Web Services
    /// account.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the environment owner. This ARN can be the
    /// ARN of any
    /// IAM principal. If this value is not specified, the ARN defaults to this
    /// environment's
    /// creator.
    owner_arn: ?[]const u8 = null,

    /// The ID of the subnet in Amazon VPC that Cloud9 will use to communicate with
    /// the Amazon EC2
    /// instance.
    subnet_id: ?[]const u8 = null,

    /// An array of key-value pairs that will be associated with the new Cloud9
    /// development
    /// environment.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .automatic_stop_time_minutes = "automaticStopTimeMinutes",
        .client_request_token = "clientRequestToken",
        .connection_type = "connectionType",
        .description = "description",
        .dry_run = "dryRun",
        .image_id = "imageId",
        .instance_type = "instanceType",
        .name = "name",
        .owner_arn = "ownerArn",
        .subnet_id = "subnetId",
        .tags = "tags",
    };
};

pub const CreateEnvironmentEC2Output = struct {
    /// The ID of the environment that was created.
    environment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentEC2Input, options: Options) !CreateEnvironmentEC2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloud9");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentEC2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloud9", "Cloud9", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCloud9WorkspaceManagementService.CreateEnvironmentEC2");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentEC2Output {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEnvironmentEC2Output, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
