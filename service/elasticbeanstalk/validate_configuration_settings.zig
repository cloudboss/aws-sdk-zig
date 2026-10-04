const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationOptionSetting = @import("configuration_option_setting.zig").ConfigurationOptionSetting;
const ValidationMessage = @import("validation_message.zig").ValidationMessage;
const serde = @import("serde.zig");

pub const ValidateConfigurationSettingsInput = struct {
    /// The name of the application that the configuration template or environment
    /// belongs
    /// to.
    application_name: []const u8,

    /// The name of the environment to validate the settings against.
    ///
    /// Condition: You cannot specify both this and a configuration template name.
    environment_name: ?[]const u8 = null,

    /// A list of the options and desired values to evaluate.
    option_settings: []const ConfigurationOptionSetting,

    /// The name of the configuration template to validate the settings against.
    ///
    /// Condition: You cannot specify both this and an environment name.
    template_name: ?[]const u8 = null,
};

pub const ValidateConfigurationSettingsOutput = struct {
    /// A list of ValidationMessage.
    messages: ?[]const ValidationMessage = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateConfigurationSettingsInput, options: CallOptions) !ValidateConfigurationSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateConfigurationSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ValidateConfigurationSettings&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    for (input.option_settings, 0..) |item, idx| {
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateConfigurationSettingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ValidateConfigurationSettingsResult")) break;
            },
            else => {},
        }
    }

    var result: ValidateConfigurationSettingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Messages")) {
                    result.messages = try serde.deserializeValidationMessagesList(allocator, &reader, "member");
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
