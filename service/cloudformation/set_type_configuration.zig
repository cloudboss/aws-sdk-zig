const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;

pub const SetTypeConfigurationInput = struct {
    /// The configuration data for the extension in this account and Region.
    ///
    /// The configuration data must be formatted as JSON and validate against the
    /// extension's
    /// schema returned in the `Schema` response element of
    /// [DescribeType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_DescribeType.html).
    configuration: []const u8,

    /// An alias by which to refer to this extension configuration data.
    ///
    /// Conditional: Specifying a configuration alias is required when setting a
    /// configuration for
    /// a resource type extension.
    configuration_alias: ?[]const u8 = null,

    /// The type of extension.
    ///
    /// Conditional: You must specify `ConfigurationArn`, or `Type` and
    /// `TypeName`.
    type: ?ThirdPartyType = null,

    /// The Amazon Resource Name (ARN) for the extension in this account and Region.
    ///
    /// For public extensions, this will be the ARN assigned when you call the
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html) API operation in this account and Region. For private extensions, this
    /// will be the ARN assigned when you call the
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html) API
    /// operation in this account and Region.
    ///
    /// Do not include the extension versions suffix at the end of the ARN. You can
    /// set the
    /// configuration for an extension, but not for a specific extension version.
    type_arn: ?[]const u8 = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify `ConfigurationArn`, or `Type` and
    /// `TypeName`.
    type_name: ?[]const u8 = null,
};

pub const SetTypeConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) for the configuration data in this account
    /// and
    /// Region.
    ///
    /// Conditional: You must specify `ConfigurationArn`, or `Type` and
    /// `TypeName`.
    configuration_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetTypeConfigurationInput, options: CallOptions) !SetTypeConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetTypeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetTypeConfiguration&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&Configuration=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.configuration);
    if (input.configuration_alias) |v| {
        try body_buf.appendSlice(allocator, "&ConfigurationAlias=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type) |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_arn) |v| {
        try body_buf.appendSlice(allocator, "&TypeArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetTypeConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SetTypeConfigurationResult")) break;
            },
            else => {},
        }
    }

    var result: SetTypeConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfigurationArn")) {
                    result.configuration_arn = try allocator.dupe(u8, try reader.readElementText());
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
