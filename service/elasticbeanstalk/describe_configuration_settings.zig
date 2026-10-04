const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationSettingsDescription = @import("configuration_settings_description.zig").ConfigurationSettingsDescription;
const serde = @import("serde.zig");

pub const DescribeConfigurationSettingsInput = struct {
    /// The application for the environment or configuration template.
    application_name: []const u8,

    /// The name of the environment to describe.
    ///
    /// Condition: You must specify either this or a TemplateName, but not both. If
    /// you
    /// specify both, AWS Elastic Beanstalk returns an `InvalidParameterCombination`
    /// error.
    /// If you do not specify either, AWS Elastic Beanstalk returns
    /// `MissingRequiredParameter` error.
    environment_name: ?[]const u8 = null,

    /// The name of the configuration template to describe.
    ///
    /// Conditional: You must specify either this parameter or an EnvironmentName,
    /// but not
    /// both. If you specify both, AWS Elastic Beanstalk returns an
    /// `InvalidParameterCombination` error. If you do not specify either, AWS
    /// Elastic
    /// Beanstalk returns a `MissingRequiredParameter` error.
    template_name: ?[]const u8 = null,
};

pub const DescribeConfigurationSettingsOutput = struct {
    /// A list of ConfigurationSettingsDescription.
    configuration_settings: ?[]const ConfigurationSettingsDescription = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConfigurationSettingsInput, options: CallOptions) !DescribeConfigurationSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConfigurationSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeConfigurationSettings&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConfigurationSettingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeConfigurationSettingsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeConfigurationSettingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfigurationSettings")) {
                    result.configuration_settings = try serde.deserializeConfigurationSettingsDescriptionList(allocator, &reader, "member");
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
