const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalingParameters = @import("scaling_parameters.zig").ScalingParameters;
const ScalingParametersStatus = @import("scaling_parameters_status.zig").ScalingParametersStatus;
const serde = @import("serde.zig");

pub const UpdateScalingParametersInput = struct {
    domain_name: []const u8,

    scaling_parameters: ScalingParameters,
};

pub const UpdateScalingParametersOutput = struct {
    scaling_parameters: ?ScalingParametersStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScalingParametersInput, options: CallOptions) !UpdateScalingParametersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudsearch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScalingParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearch", "CloudSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateScalingParameters&Version=2013-01-01");
    try body_buf.appendSlice(allocator, "&DomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain_name);
    if (input.scaling_parameters.desired_instance_type) |sv| {
        try body_buf.appendSlice(allocator, "&ScalingParameters.DesiredInstanceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.scaling_parameters.desired_partition_count) |sv| {
        try body_buf.appendSlice(allocator, "&ScalingParameters.DesiredPartitionCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.scaling_parameters.desired_replication_count) |sv| {
        try body_buf.appendSlice(allocator, "&ScalingParameters.DesiredReplicationCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScalingParametersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateScalingParametersResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateScalingParametersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ScalingParameters")) {
                    result.scaling_parameters = try serde.deserializeScalingParametersStatus(allocator, &reader);
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
