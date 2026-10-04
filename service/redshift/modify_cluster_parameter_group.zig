const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Parameter = @import("parameter.zig").Parameter;
const serde = @import("serde.zig");

pub const ModifyClusterParameterGroupInput = struct {
    /// The name of the parameter group to be modified.
    parameter_group_name: []const u8,

    /// An array of parameters to be modified. A maximum of 20 parameters can be
    /// modified
    /// in a single request.
    ///
    /// For each parameter to be modified, you must supply at least the parameter
    /// name and
    /// parameter value; other name-value pairs of the parameter are optional.
    ///
    /// For the workload management (WLM) configuration, you must supply all the
    /// name-value
    /// pairs in the wlm_json_configuration parameter.
    parameters: []const Parameter,
};

pub const ModifyClusterParameterGroupOutput = struct {
    /// The name of the cluster parameter group.
    parameter_group_name: ?[]const u8 = null,

    /// The status of the parameter group. For example, if you made a change to a
    /// parameter
    /// group name-value pair, then the change could be pending a reboot of an
    /// associated
    /// cluster.
    parameter_group_status: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyClusterParameterGroupInput, options: CallOptions) !ModifyClusterParameterGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyClusterParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyClusterParameterGroup&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.parameter_group_name);
    for (input.parameters, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.allowed_values) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.AllowedValues=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.apply_type) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.ApplyType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.data_type) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.DataType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.description) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.is_modifiable) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.IsModifiable=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.minimum_engine_version) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.MinimumEngineVersion=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.parameter_name) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.ParameterName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.parameter_value) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.ParameterValue=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.source) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.Source=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyClusterParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyClusterParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyClusterParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ParameterGroupName")) {
                    result.parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterGroupStatus")) {
                    result.parameter_group_status = try allocator.dupe(u8, try reader.readElementText());
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
