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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyInstancePlacementOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstancePlacementInput, options: Options) !ModifyInstancePlacementOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstancePlacementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstancePlacement&Version=2016-11-15");
    if (input.affinity) |v| {
        try body_buf.appendSlice(alloc, "&Affinity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.group_id) |v| {
        try body_buf.appendSlice(alloc, "&GroupId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(alloc, "&GroupName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.host_id) |v| {
        try body_buf.appendSlice(alloc, "&HostId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.host_resource_group_arn) |v| {
        try body_buf.appendSlice(alloc, "&HostResourceGroupArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.partition_number) |v| {
        try body_buf.appendSlice(alloc, "&PartitionNumber=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.tenancy) |v| {
        try body_buf.appendSlice(alloc, "&Tenancy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstancePlacementOutput {
    _ = status;
    _ = headers;
    _ = alloc;
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
