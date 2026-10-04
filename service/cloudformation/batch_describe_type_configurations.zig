const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TypeConfigurationIdentifier = @import("type_configuration_identifier.zig").TypeConfigurationIdentifier;
const BatchDescribeTypeConfigurationsError = @import("batch_describe_type_configurations_error.zig").BatchDescribeTypeConfigurationsError;
const TypeConfigurationDetails = @import("type_configuration_details.zig").TypeConfigurationDetails;
const serde = @import("serde.zig");

pub const BatchDescribeTypeConfigurationsInput = struct {
    /// The list of identifiers for the desired extension configurations.
    type_configuration_identifiers: []const TypeConfigurationIdentifier,
};

pub const BatchDescribeTypeConfigurationsOutput = struct {
    /// A list of information concerning any errors generated during the setting of
    /// the specified
    /// configurations.
    errors: ?[]const BatchDescribeTypeConfigurationsError = null,

    /// A list of any of the specified extension configurations from the
    /// CloudFormation
    /// registry.
    type_configurations: ?[]const TypeConfigurationDetails = null,

    /// A list of any of the specified extension configurations that CloudFormation
    /// could not process
    /// for any reason.
    unprocessed_type_configurations: ?[]const TypeConfigurationIdentifier = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDescribeTypeConfigurationsInput, options: CallOptions) !BatchDescribeTypeConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDescribeTypeConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=BatchDescribeTypeConfigurations&Version=2010-05-15");
    for (input.type_configuration_identifiers, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.@"type") |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TypeConfigurationIdentifiers.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.type_arn) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TypeConfigurationIdentifiers.member.{d}.TypeArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.type_configuration_alias) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TypeConfigurationIdentifiers.member.{d}.TypeConfigurationAlias=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.type_configuration_arn) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TypeConfigurationIdentifiers.member.{d}.TypeConfigurationArn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.type_name) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TypeConfigurationIdentifiers.member.{d}.TypeName=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDescribeTypeConfigurationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BatchDescribeTypeConfigurationsResult")) break;
            },
            else => {},
        }
    }

    var result: BatchDescribeTypeConfigurationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try serde.deserializeBatchDescribeTypeConfigurationsErrors(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "TypeConfigurations")) {
                    result.type_configurations = try serde.deserializeTypeConfigurationDetailsList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "UnprocessedTypeConfigurations")) {
                    result.unprocessed_type_configurations = try serde.deserializeUnprocessedTypeConfigurations(allocator, &reader, "member");
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
