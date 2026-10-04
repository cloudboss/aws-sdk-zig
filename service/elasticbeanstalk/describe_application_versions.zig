const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationVersionDescription = @import("application_version_description.zig").ApplicationVersionDescription;
const serde = @import("serde.zig");

pub const DescribeApplicationVersionsInput = struct {
    /// Specify an application name to show only application versions for that
    /// application.
    application_name: ?[]const u8 = null,

    /// For a paginated request. Specify a maximum number of application versions to
    /// include in
    /// each response.
    ///
    /// If no `MaxRecords` is specified, all available application versions are
    /// retrieved in a single response.
    max_records: ?i32 = null,

    /// For a paginated request. Specify a token from a previous response page to
    /// retrieve the next response page. All other
    /// parameter values must be identical to the ones specified in the initial
    /// request.
    ///
    /// If no `NextToken` is specified, the first page is retrieved.
    next_token: ?[]const u8 = null,

    /// Specify a version label to show a specific application version.
    version_labels: ?[]const []const u8 = null,
};

pub const DescribeApplicationVersionsOutput = struct {
    /// List of `ApplicationVersionDescription` objects sorted in order of
    /// creation.
    application_versions: ?[]const ApplicationVersionDescription = null,

    /// In a paginated request, the token that you can pass in a subsequent request
    /// to get the
    /// next response page.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationVersionsInput, options: CallOptions) !DescribeApplicationVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeApplicationVersions&Version=2010-12-01");
    if (input.application_name) |v| {
        try body_buf.appendSlice(allocator, "&ApplicationName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_labels) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VersionLabels.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeApplicationVersionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeApplicationVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationVersions")) {
                    result.application_versions = try serde.deserializeApplicationVersionDescriptionList(allocator, &reader, "member");
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
