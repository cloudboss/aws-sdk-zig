const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentDescription = @import("environment_description.zig").EnvironmentDescription;
const serde = @import("serde.zig");

pub const DescribeEnvironmentsInput = struct {
    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// include only
    /// those that are associated with this application.
    application_name: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// include only
    /// those that have the specified IDs.
    environment_ids: ?[]const []const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// include only
    /// those that have the specified names.
    environment_names: ?[]const []const u8 = null,

    /// If specified when `IncludeDeleted` is set to `true`, then
    /// environments deleted after this date are displayed.
    included_deleted_back_to: ?i64 = null,

    /// Indicates whether to include deleted environments:
    ///
    /// `true`: Environments that have been deleted after
    /// `IncludedDeletedBackTo` are displayed.
    ///
    /// `false`: Do not include deleted environments.
    include_deleted: ?bool = null,

    /// For a paginated request. Specify a maximum number of environments to include
    /// in
    /// each response.
    ///
    /// If no `MaxRecords` is specified, all available environments are
    /// retrieved in a single response.
    max_records: ?i32 = null,

    /// For a paginated request. Specify a token from a previous response page to
    /// retrieve the next response page. All other
    /// parameter values must be identical to the ones specified in the initial
    /// request.
    ///
    /// If no `NextToken` is specified, the first page is retrieved.
    next_token: ?[]const u8 = null,

    /// If specified, AWS Elastic Beanstalk restricts the returned descriptions to
    /// include only
    /// those that are associated with this application version.
    version_label: ?[]const u8 = null,
};

pub const DescribeEnvironmentsOutput = struct {
    /// Returns an EnvironmentDescription list.
    environments: ?[]const EnvironmentDescription = null,

    /// In a paginated request, the token that you can pass in a subsequent request
    /// to get the
    /// next response page.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEnvironmentsInput, options: CallOptions) !DescribeEnvironmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEnvironmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEnvironments&Version=2010-12-01");
    if (input.application_name) |v| {
        try body_buf.appendSlice(allocator, "&ApplicationName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EnvironmentIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.environment_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&EnvironmentNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.included_deleted_back_to) |v| {
        try body_buf.appendSlice(allocator, "&IncludedDeletedBackTo=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.include_deleted) |v| {
        try body_buf.appendSlice(allocator, "&IncludeDeleted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_label) |v| {
        try body_buf.appendSlice(allocator, "&VersionLabel=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEnvironmentsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEnvironmentsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEnvironmentsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Environments")) {
                    result.environments = try serde.deserializeEnvironmentDescriptionsList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
