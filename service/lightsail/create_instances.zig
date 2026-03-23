const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AddOnRequest = @import("add_on_request.zig").AddOnRequest;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateInstancesInput = struct {
    /// An array of objects representing the add-ons to enable for the new instance.
    add_ons: ?[]const AddOnRequest = null,

    /// The Availability Zone in which to create your instance. Use the following
    /// format:
    /// `us-east-2a` (case sensitive). You can get a list of Availability Zones by
    /// using
    /// the [get
    /// regions](http://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetRegions.html) operation. Be sure to add the `include Availability Zones`
    /// parameter to your request.
    availability_zone: []const u8,

    /// The ID for a virtual private server image (`app_wordpress_x_x` or
    /// `app_lamp_x_x`). Use the `get blueprints` operation to return a list
    /// of available images (or *blueprints*).
    ///
    /// Use active blueprints when creating new instances. Inactive blueprints are
    /// listed to
    /// support customers with existing instances and are not necessarily available
    /// to create new
    /// instances. Blueprints are marked inactive when they become outdated due to
    /// operating system
    /// updates or new application releases.
    blueprint_id: []const u8,

    /// The bundle of specification information for your virtual private server (or
    /// *instance*), including the pricing plan (`medium_x_x`).
    bundle_id: []const u8,

    /// (Discontinued) The name for your custom image.
    ///
    /// In releases prior to June 12, 2017, this parameter was ignored by the API.
    /// It is now
    /// discontinued.
    custom_image_name: ?[]const u8 = null,

    /// The names to use for your new Lightsail instances. Separate multiple values
    /// using
    /// quotation marks and commas, for example:
    /// `["MyFirstInstance","MySecondInstance"]`
    instance_names: []const []const u8,

    /// The IP address type for the instance.
    ///
    /// The possible values are `ipv4` for IPv4 only, `ipv6` for IPv6 only,
    /// and `dualstack` for IPv4 and IPv6.
    ///
    /// The default value is `dualstack`.
    ip_address_type: ?IpAddressType = null,

    /// The name of your key pair.
    key_pair_name: ?[]const u8 = null,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    /// A launch script you can create that configures a server with additional user
    /// data. For
    /// example, you might want to run `apt-get -y update`.
    ///
    /// Depending on the machine image you choose, the command to get software on
    /// your instance
    /// varies. Amazon Linux and CentOS use `yum`, Debian and Ubuntu use
    /// `apt-get`, and FreeBSD uses `pkg`. For a complete list, see the
    /// [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/compare-options-choose-lightsail-instance-image).
    user_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .add_ons = "addOns",
        .availability_zone = "availabilityZone",
        .blueprint_id = "blueprintId",
        .bundle_id = "bundleId",
        .custom_image_name = "customImageName",
        .instance_names = "instanceNames",
        .ip_address_type = "ipAddressType",
        .key_pair_name = "keyPairName",
        .tags = "tags",
        .user_data = "userData",
    };
};

pub const CreateInstancesOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstancesInput, options: CallOptions) !CreateInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInstancesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
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
