const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Parameter = @import("parameter.zig").Parameter;
const serde = @import("serde.zig");

pub const ResetDBParameterGroupInput = struct {
    /// The name of the DB parameter group.
    ///
    /// Constraints:
    ///
    /// * Must match the name of an existing DBParameterGroup.
    db_parameter_group_name: []const u8,

    /// To reset the entire DB parameter group, specify the `DBParameterGroup` name
    /// and
    /// `ResetAllParameters` parameters. To reset specific parameters, provide a
    /// list of
    /// the following: `ParameterName` and `ApplyMethod`. A maximum of 20
    /// parameters can be modified in a single request.
    ///
    /// Valid Values (for Apply method): `pending-reboot`
    parameters: ?[]const Parameter = null,

    /// Specifies whether (`true`) or not (`false`) to reset all parameters
    /// in the DB parameter group to default values.
    ///
    /// Default: `true`
    reset_all_parameters: ?bool = null,
};

pub const ResetDBParameterGroupOutput = struct {
    /// Provides the name of the DB parameter group.
    db_parameter_group_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetDBParameterGroupInput, options: CallOptions) !ResetDBParameterGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetDBParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ResetDBParameterGroup&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_parameter_group_name);
    if (input.parameters) |list| {
        for (list, 0..) |item, idx| {
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
                if (item.apply_method) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.ApplyMethod=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.apply_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.ApplyType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
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
    }
    if (input.reset_all_parameters) |v| {
        try body_buf.appendSlice(allocator, "&ResetAllParameters=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetDBParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResetDBParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ResetDBParameterGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBParameterGroupName")) {
                    result.db_parameter_group_name = try allocator.dupe(u8, try reader.readElementText());
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
