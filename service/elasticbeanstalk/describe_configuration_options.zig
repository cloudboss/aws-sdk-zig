const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OptionSpecification = @import("option_specification.zig").OptionSpecification;
const ConfigurationOptionDescription = @import("configuration_option_description.zig").ConfigurationOptionDescription;
const serde = @import("serde.zig");

pub const DescribeConfigurationOptionsInput = struct {
    /// The name of the application associated with the configuration template or
    /// environment.
    /// Only needed if you want to describe the configuration options associated
    /// with either the
    /// configuration template or environment.
    application_name: ?[]const u8 = null,

    /// The name of the environment whose configuration options you want to
    /// describe.
    environment_name: ?[]const u8 = null,

    /// If specified, restricts the descriptions to only the specified options.
    options: ?[]const OptionSpecification = null,

    /// The ARN of the custom platform.
    platform_arn: ?[]const u8 = null,

    /// The name of the solution stack whose configuration options you want to
    /// describe.
    solution_stack_name: ?[]const u8 = null,

    /// The name of the configuration template whose configuration options you want
    /// to
    /// describe.
    template_name: ?[]const u8 = null,
};

pub const DescribeConfigurationOptionsOutput = struct {
    /// A list of ConfigurationOptionDescription.
    options: ?[]const ConfigurationOptionDescription = null,

    /// The ARN of the platform version.
    platform_arn: ?[]const u8 = null,

    /// The name of the solution stack these configuration options belong to.
    solution_stack_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationOptionsInput, options: CallOptions) !DescribeConfigurationOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeConfigurationOptions&Version=2010-12-01");
    if (input.application_name) |v| {
        try body_buf.appendSlice(allocator, "&ApplicationName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.options) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.namespace) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.member.{d}.Namespace=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.option_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.member.{d}.OptionName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Options.member.{d}.ResourceName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.platform_arn) |v| {
        try body_buf.appendSlice(allocator, "&PlatformArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.solution_stack_name) |v| {
        try body_buf.appendSlice(allocator, "&SolutionStackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.template_name) |v| {
        try body_buf.appendSlice(allocator, "&TemplateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigurationOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeConfigurationOptionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeConfigurationOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Options")) {
                    result.options = try serde.deserializeConfigurationOptionDescriptionsList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "PlatformArn")) {
                    result.platform_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SolutionStackName")) {
                    result.solution_stack_name = try allocator.dupe(u8, try reader.readElementText());
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
