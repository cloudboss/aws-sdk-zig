const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeprecatedStatus = @import("deprecated_status.zig").DeprecatedStatus;
const RegistryType = @import("registry_type.zig").RegistryType;
const TypeVersionSummary = @import("type_version_summary.zig").TypeVersionSummary;
const serde = @import("serde.zig");

pub const ListTypeVersionsInput = struct {
    /// The Amazon Resource Name (ARN) of the extension for which you want version
    /// summary
    /// information.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    arn: ?[]const u8 = null,

    /// The deprecation status of the extension versions that you want to get
    /// summary information
    /// about.
    ///
    /// Valid values include:
    ///
    /// * `LIVE`: The extension version is registered and can be used in
    ///   CloudFormation
    /// operations, dependent on its provisioning behavior and visibility scope.
    ///
    /// * `DEPRECATED`: The extension version has been deregistered and can no
    ///   longer
    /// be used in CloudFormation operations.
    ///
    /// The default is `LIVE`.
    deprecated_status: ?DeprecatedStatus = null,

    /// The maximum number of results to be returned with a single call. If the
    /// number of
    /// available results exceeds this maximum, the response includes a `NextToken`
    /// value
    /// that you can assign to the `NextToken` request parameter to get the next set
    /// of
    /// results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The publisher ID of the extension publisher.
    ///
    /// Extensions published by Amazon aren't assigned a publisher ID.
    publisher_id: ?[]const u8 = null,

    /// The kind of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    type: ?RegistryType = null,

    /// The name of the extension for which you want version summary information.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    type_name: ?[]const u8 = null,
};

pub const ListTypeVersionsOutput = struct {
    /// If the request doesn't return all of the remaining results, `NextToken` is
    /// set
    /// to a token. To retrieve the next set of results, call this action again and
    /// assign that token
    /// to the request object's `NextToken` parameter. If the request returns all
    /// results,
    /// `NextToken` is set to `null`.
    next_token: ?[]const u8 = null,

    /// A list of `TypeVersionSummary` structures that contain information about the
    /// specified extension's versions.
    type_version_summaries: ?[]const TypeVersionSummary = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTypeVersionsInput, options: CallOptions) !ListTypeVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTypeVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListTypeVersions&Version=2010-05-15");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "&Arn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.deprecated_status) |v| {
        try body_buf.appendSlice(allocator, "&DeprecatedStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTypeVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListTypeVersionsResult")) break;
            },
            else => {},
        }
    }

    var result: ListTypeVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeVersionSummaries")) {
                    result.type_version_summaries = try serde.deserializeTypeVersionSummaries(allocator, &reader, "member");
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
