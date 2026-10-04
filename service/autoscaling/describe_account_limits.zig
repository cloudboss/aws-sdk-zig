const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeAccountLimitsInput = struct {};

pub const DescribeAccountLimitsOutput = struct {
    /// The maximum number of groups allowed for your account. The default is 200
    /// groups per
    /// Region.
    max_number_of_auto_scaling_groups: ?i32 = null,

    /// The maximum number of launch configurations allowed for your account. The
    /// default is
    /// 200 launch configurations per Region.
    max_number_of_launch_configurations: ?i32 = null,

    /// The current number of groups for your account.
    number_of_auto_scaling_groups: ?i32 = null,

    /// The current number of launch configurations for your account.
    number_of_launch_configurations: ?i32 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountLimitsInput, options: CallOptions) !DescribeAccountLimitsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountLimitsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeAccountLimits&Version=2011-01-01");

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountLimitsOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeAccountLimitsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeAccountLimitsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MaxNumberOfAutoScalingGroups")) {
                    result.max_number_of_auto_scaling_groups = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxNumberOfLaunchConfigurations")) {
                    result.max_number_of_launch_configurations = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NumberOfAutoScalingGroups")) {
                    result.number_of_auto_scaling_groups = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NumberOfLaunchConfigurations")) {
                    result.number_of_launch_configurations = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
