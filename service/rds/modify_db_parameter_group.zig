const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Parameter = @import("parameter.zig").Parameter;
const serde = @import("serde.zig");

pub const ModifyDBParameterGroupInput = struct {
    /// The name of the DB parameter group.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the name of an existing `DBParameterGroup`.
    db_parameter_group_name: []const u8,

    /// An array of parameter names, values, and the application methods for the
    /// parameter update. At least one parameter name, value, and application method
    /// must be supplied; later arguments are optional. A maximum of 20 parameters
    /// can be modified in a single request.
    ///
    /// Valid Values (for the application method): `immediate | pending-reboot`
    ///
    /// You can use the `immediate` value with dynamic parameters only. You can use
    /// the `pending-reboot` value for both dynamic and static parameters.
    ///
    /// When the application method is `immediate`, changes to dynamic parameters
    /// are applied immediately to the DB instances associated with the parameter
    /// group.
    ///
    /// When the application method is `pending-reboot`, changes to dynamic and
    /// static parameters are applied after a reboot without failover to the DB
    /// instances associated with the parameter group.
    ///
    /// You can't use `pending-reboot` with dynamic parameters on RDS for SQL Server
    /// DB instances. Use `immediate`.
    ///
    /// For more information on modifying DB parameters, see [Working with DB
    /// parameter
    /// groups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithParamGroups.html) in the *Amazon RDS User Guide*.
    parameters: []const Parameter,
};

pub const ModifyDBParameterGroupOutput = struct {
    /// The name of the DB parameter group.
    db_parameter_group_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBParameterGroupInput, options: CallOptions) !ModifyDBParameterGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBParameterGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBParameterGroup&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBParameterGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_parameter_group_name);
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
        if (item.supported_engine_modes) |lst_1| {
            for (lst_1, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Parameters.Parameter.{d}.SupportedEngineModes.member.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBParameterGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBParameterGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBParameterGroupOutput = .{};
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
