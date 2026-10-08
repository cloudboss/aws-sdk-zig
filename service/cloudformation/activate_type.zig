const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;
const VersionBump = @import("version_bump.zig").VersionBump;
const serde = @import("serde.zig");

pub const ActivateTypeInput = struct {
    /// Whether to automatically update the extension in this account and Region
    /// when a new
    /// *minor* version is published by the extension publisher. Major versions
    /// released by the publisher must be manually updated.
    ///
    /// The default is `true`.
    auto_update: ?bool = null,

    /// The name of the IAM execution role to use to activate the extension.
    execution_role_arn: ?[]const u8 = null,

    /// Contains logging configuration information for an extension.
    logging_config: ?LoggingConfig = null,

    /// The major version of this extension you want to activate, if multiple major
    /// versions are
    /// available. The default is the latest major version. CloudFormation uses the
    /// latest available
    /// *minor* version of the major version selected.
    ///
    /// You can specify `MajorVersion` or `VersionBump`, but not
    /// both.
    major_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the public extension.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    public_type_arn: ?[]const u8 = null,

    /// The ID of the extension publisher.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    publisher_id: ?[]const u8 = null,

    /// The extension type.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    type: ?ThirdPartyType = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify `PublicTypeArn`, or `TypeName`,
    /// `Type`, and `PublisherId`.
    type_name: ?[]const u8 = null,

    /// An alias to assign to the public extension in this account and Region. If
    /// you specify an
    /// alias for the extension, CloudFormation treats the alias as the extension
    /// type name within this
    /// account and Region. You must use the alias to refer to the extension in your
    /// templates, API
    /// calls, and CloudFormation console.
    ///
    /// An extension alias must be unique within a given account and Region. You can
    /// activate the
    /// same public resource multiple times in the same account and Region, using
    /// different type name
    /// aliases.
    type_name_alias: ?[]const u8 = null,

    /// Manually updates a previously-activated type to a new major or minor
    /// version, if
    /// available. You can also use this parameter to update the value of
    /// `AutoUpdate`.
    ///
    /// * `MAJOR`: CloudFormation updates the extension to the newest major version,
    ///   if
    /// one is available.
    ///
    /// * `MINOR`: CloudFormation updates the extension to the newest minor version,
    ///   if
    /// one is available.
    version_bump: ?VersionBump = null,
};

pub const ActivateTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the activated extension in this account
    /// and
    /// Region.
    arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ActivateTypeInput, options: CallOptions) !ActivateTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ActivateTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ActivateType&Version=2010-05-15");
    if (input.auto_update) |v| {
        try body_buf.appendSlice(allocator, "&AutoUpdate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.execution_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&ExecutionRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.logging_config) |v| {
        try body_buf.appendSlice(allocator, "&LoggingConfig.LogGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.log_group_name);
        try body_buf.appendSlice(allocator, "&LoggingConfig.LogRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.log_role_arn);
    }
    if (input.major_version) |v| {
        try body_buf.appendSlice(allocator, "&MajorVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.public_type_arn) |v| {
        try body_buf.appendSlice(allocator, "&PublicTypeArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.publisher_id) |v| {
        try body_buf.appendSlice(allocator, "&PublisherId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type) |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.type_name_alias) |v| {
        try body_buf.appendSlice(allocator, "&TypeNameAlias=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_bump) |v| {
        try body_buf.appendSlice(allocator, "&VersionBump=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ActivateTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActivateTypeResult")) break;
            },
            else => {},
        }
    }

    var result: ActivateTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
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
