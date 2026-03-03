const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddOnRequest = @import("add_on_request.zig").AddOnRequest;
const DiskMap = @import("disk_map.zig").DiskMap;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateInstancesFromSnapshotInput = struct {
    /// An array of objects representing the add-ons to enable for the new instance.
    add_ons: ?[]const AddOnRequest = null,

    /// An object containing information about one or more disk mappings.
    attached_disk_mapping: ?[]const aws.map.MapEntry([]const DiskMap) = null,

    /// The Availability Zone where you want to create your instances. Use the
    /// following
    /// formatting: `us-east-2a` (case sensitive). You can get a list of
    /// Availability Zones
    /// by using the [get
    /// regions](http://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetRegions.html) operation. Be sure to add the `include Availability Zones`
    /// parameter to your request.
    availability_zone: []const u8,

    /// The bundle of specification information for your virtual private server (or
    /// *instance*), including the pricing plan (`micro_x_x`).
    bundle_id: []const u8,

    /// The names for your new instances.
    instance_names: []const []const u8,

    /// The name of the instance snapshot on which you are basing your new
    /// instances. Use the get
    /// instance snapshots operation to return information about your existing
    /// snapshots.
    ///
    /// Constraint:
    ///
    /// * This parameter cannot be defined together with the `source instance name`
    /// parameter. The `instance snapshot name` and `source instance name`
    /// parameters are mutually exclusive.
    instance_snapshot_name: ?[]const u8 = null,

    /// The IP address type for the instance.
    ///
    /// The possible values are `ipv4` for IPv4 only, `ipv6` for IPv6 only,
    /// and `dualstack` for IPv4 and IPv6.
    ///
    /// The default value is `dualstack`.
    ip_address_type: ?IpAddressType = null,

    /// The name for your key pair.
    key_pair_name: ?[]const u8 = null,

    /// The date of the automatic snapshot to use for the new instance. Use the `get
    /// auto
    /// snapshots` operation to identify the dates of the available automatic
    /// snapshots.
    ///
    /// Constraints:
    ///
    /// * Must be specified in `YYYY-MM-DD` format.
    ///
    /// * This parameter cannot be defined together with the `use latest restorable
    ///   auto
    /// snapshot` parameter. The `restore date` and `use latest restorable
    /// auto snapshot` parameters are mutually exclusive.
    ///
    /// * Define this parameter only when creating a new instance from an automatic
    ///   snapshot.
    /// For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    restore_date: ?[]const u8 = null,

    /// The name of the source instance from which the source automatic snapshot was
    /// created.
    ///
    /// Constraints:
    ///
    /// * This parameter cannot be defined together with the `instance snapshot
    ///   name`
    /// parameter. The `source instance name` and `instance snapshot name`
    /// parameters are mutually exclusive.
    ///
    /// * Define this parameter only when creating a new instance from an automatic
    ///   snapshot.
    /// For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    source_instance_name: ?[]const u8 = null,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    /// A Boolean value to indicate whether to use the latest available automatic
    /// snapshot.
    ///
    /// Constraints:
    ///
    /// * This parameter cannot be defined together with the `restore date`
    /// parameter. The `use latest restorable auto snapshot` and `restore
    /// date` parameters are mutually exclusive.
    ///
    /// * Define this parameter only when creating a new instance from an automatic
    ///   snapshot.
    /// For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    use_latest_restorable_auto_snapshot: ?bool = null,

    /// You can create a launch script that configures a server with additional user
    /// data. For
    /// example, `apt-get -y update`.
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
        .attached_disk_mapping = "attachedDiskMapping",
        .availability_zone = "availabilityZone",
        .bundle_id = "bundleId",
        .instance_names = "instanceNames",
        .instance_snapshot_name = "instanceSnapshotName",
        .ip_address_type = "ipAddressType",
        .key_pair_name = "keyPairName",
        .restore_date = "restoreDate",
        .source_instance_name = "sourceInstanceName",
        .tags = "tags",
        .use_latest_restorable_auto_snapshot = "useLatestRestorableAutoSnapshot",
        .user_data = "userData",
    };
};

pub const CreateInstancesFromSnapshotOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstancesFromSnapshotInput, options: Options) !CreateInstancesFromSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstancesFromSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateInstancesFromSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstancesFromSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInstancesFromSnapshotOutput, body, allocator);
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
