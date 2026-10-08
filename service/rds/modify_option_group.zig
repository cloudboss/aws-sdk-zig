const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OptionConfiguration = @import("option_configuration.zig").OptionConfiguration;
const OptionGroup = @import("option_group.zig").OptionGroup;
const serde = @import("serde.zig");

pub const ModifyOptionGroupInput = struct {
    /// Specifies whether to apply the change immediately or during the next
    /// maintenance window for each instance associated with the option group.
    apply_immediately: ?bool = null,

    /// The name of the option group to be modified.
    ///
    /// Permanent options, such as the TDE option for Oracle Advanced Security TDE,
    /// can't be removed from an option group, and that option group can't be
    /// removed from a DB instance once it is associated with a DB instance
    option_group_name: []const u8,

    /// Options in this list are added to the option group or, if already present,
    /// the specified configuration is used to update the existing configuration.
    options_to_include: ?[]const OptionConfiguration = null,

    /// Options in this list are removed from the option group.
    options_to_remove: ?[]const []const u8 = null,
};

pub const ModifyOptionGroupOutput = struct {
    option_group: ?OptionGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyOptionGroupInput, options: CallOptions) !ModifyOptionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyOptionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyOptionGroup&Version=2014-10-31");
    if (input.apply_immediately) |v| {
        try body_buf.appendSlice(allocator, "&ApplyImmediately=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&OptionGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.option_group_name);
    if (input.options_to_include) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.db_security_group_memberships) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.DBSecurityGroupMemberships.DBSecurityGroupName.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.option_name);
            }
            if (item.option_settings) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.allowed_values) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.AllowedValues=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.apply_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.ApplyType=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.data_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.DataType=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.default_value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.DefaultValue=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.description) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.Description=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.is_collection) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.IsCollection=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.is_modifiable) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.IsModifiable=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.name) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.Name=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionSettings.OptionSetting.{d}.Value=", .{ n, n_1 }) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.option_version) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.OptionVersion=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.port) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.Port=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.vpc_security_group_memberships) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToInclude.OptionConfiguration.{d}.VpcSecurityGroupMemberships.VpcSecurityGroupId.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.options_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionsToRemove.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyOptionGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyOptionGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyOptionGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OptionGroup")) {
                    result.option_group = try serde.deserializeOptionGroup(allocator, &reader);
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
