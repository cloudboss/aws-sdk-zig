const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Affinity = @import("affinity.zig").Affinity;
const HostTenancy = @import("host_tenancy.zig").HostTenancy;

pub const ModifyInstancePlacementInput = struct {
    /// The affinity setting for the instance. For more information, see [Host
    /// affinity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-dedicated-hosts-work.html#dedicated-hosts-affinity) in the *Amazon EC2 User Guide*.
    affinity: ?Affinity = null,

    /// The Group Id of a placement group. You must specify the Placement Group
    /// **Group Id** to launch an instance in a shared placement
    /// group.
    group_id: ?[]const u8 = null,

    /// The name of the placement group in which to place the instance. For spread
    /// placement
    /// groups, the instance must have a tenancy of `default`. For cluster and
    /// partition placement groups, the instance must have a tenancy of `default` or
    /// `dedicated`.
    ///
    /// To remove an instance from a placement group, specify an empty string ("").
    group_name: ?[]const u8 = null,

    /// The ID of the Dedicated Host with which to associate the instance.
    host_id: ?[]const u8 = null,

    /// The ARN of the host resource group in which to place the instance. The
    /// instance must
    /// have a tenancy of `host` to specify this parameter.
    host_resource_group_arn: ?[]const u8 = null,

    /// The ID of the instance that you are modifying.
    instance_id: []const u8,

    /// The number of the partition in which to place the instance. Valid only if
    /// the
    /// placement group strategy is set to `partition`.
    partition_number: ?i32 = null,

    /// The tenancy for the instance.
    ///
    /// For T3 instances, you must launch the instance on a Dedicated Host to use a
    /// tenancy of `host`. You can't change the tenancy from
    /// `host` to `dedicated` or `default`.
    /// Attempting to make one of these unsupported tenancy changes results in an
    /// `InvalidRequest` error code.
    tenancy: ?HostTenancy = null,
};

pub const ModifyInstancePlacementOutput = struct {
    /// Is `true` if the request succeeds, and an error otherwise.
    @"return": ?bool = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyInstancePlacementInput, options: Options) !ModifyInstancePlacementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyInstancePlacementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyInstancePlacement&Version=2016-11-15");
    if (input.affinity) |v| {
        try body_buf.appendSlice(allocator, "&Affinity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.group_id) |v| {
        try body_buf.appendSlice(allocator, "&GroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(allocator, "&GroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.host_id) |v| {
        try body_buf.appendSlice(allocator, "&HostId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.host_resource_group_arn) |v| {
        try body_buf.appendSlice(allocator, "&HostResourceGroupArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
    if (input.partition_number) |v| {
        try body_buf.appendSlice(allocator, "&PartitionNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.tenancy) |v| {
        try body_buf.appendSlice(allocator, "&Tenancy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyInstancePlacementOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyInstancePlacementOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
