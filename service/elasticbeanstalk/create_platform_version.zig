const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const S3Location = @import("s3_location.zig").S3Location;
const Tag = @import("tag.zig").Tag;
const Builder = @import("builder.zig").Builder;
const PlatformSummary = @import("platform_summary.zig").PlatformSummary;
const serde = @import("serde.zig");

pub const CreatePlatformVersionInput = struct {
    /// The name of the builder environment.
    environment_name: ?[]const u8 = null,

    /// The configuration option settings to apply to the builder environment.
    option_settings: ?[]const ConfigurationOptionSetting = null,

    /// The location of the platform definition archive in Amazon S3.
    platform_definition_bundle: S3Location,

    /// The name of your custom platform.
    platform_name: []const u8,

    /// The number, such as 1.0.2, for the new platform version.
    platform_version: []const u8,

    /// Specifies the tags applied to the new platform version.
    ///
    /// Elastic Beanstalk applies these tags only to the platform version.
    /// Environments that you create using
    /// the platform version don't inherit the tags.
    tags: ?[]const Tag = null,
};

pub const CreatePlatformVersionOutput = struct {
    /// The builder used to create the custom platform.
    builder: ?Builder = null,

    /// Detailed information about the new version of the custom platform.
    platform_summary: ?PlatformSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlatformVersionInput, options: CallOptions) !CreatePlatformVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticbeanstalk", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlatformVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreatePlatformVersion&Version=2010-12-01");
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.option_settings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.namespace) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.Namespace=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.option_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.OptionName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.ResourceName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OptionSettings.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.platform_definition_bundle.s3_bucket) |sv| {
        try body_buf.appendSlice(allocator, "&PlatformDefinitionBundle.S3Bucket=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.platform_definition_bundle.s3_key) |sv| {
        try body_buf.appendSlice(allocator, "&PlatformDefinitionBundle.S3Key=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    try body_buf.appendSlice(allocator, "&PlatformName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform_name);
    try body_buf.appendSlice(allocator, "&PlatformVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform_version);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlatformVersionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatePlatformVersionResult")) break;
            },
            else => {},
        }
    }

    var result: CreatePlatformVersionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Builder")) {
                    result.builder = try serde.deserializeBuilder(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "PlatformSummary")) {
                    result.platform_summary = try serde.deserializePlatformSummary(allocator, &reader);
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
