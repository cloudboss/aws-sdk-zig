const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;

pub const PublishTypeInput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    arn: ?[]const u8 = null,

    /// The version number to assign to this version of the extension.
    ///
    /// Use the following format, and adhere to semantic versioning when assigning a
    /// version
    /// number to your extension:
    ///
    /// `MAJOR.MINOR.PATCH`
    ///
    /// For more information, see [Semantic Versioning
    /// 2.0.0](https://semver.org/).
    ///
    /// If you don't specify a version number, CloudFormation increments the version
    /// number by one
    /// minor version release.
    ///
    /// You cannot specify a version number the first time you publish a type.
    /// CloudFormation
    /// automatically sets the first version number to be `1.0.0`.
    public_version_number: ?[]const u8 = null,

    /// The type of the extension.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    @"type": ?ThirdPartyType = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify `Arn`, or `TypeName` and
    /// `Type`.
    type_name: ?[]const u8 = null,
};

pub const PublishTypeOutput = struct {
    /// The Amazon Resource Name (ARN) assigned to the public extension upon
    /// publication.
    public_type_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishTypeInput, options: CallOptions) !PublishTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PublishType&Version=2010-05-15");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "&Arn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.public_version_number) |v| {
        try body_buf.appendSlice(allocator, "&PublicVersionNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishTypeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PublishTypeResult")) break;
            },
            else => {},
        }
    }

    var result: PublishTypeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PublicTypeArn")) {
                    result.public_type_arn = try allocator.dupe(u8, try reader.readElementText());
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
