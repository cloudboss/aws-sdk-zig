const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationResourceLifecycleConfig = @import("application_resource_lifecycle_config.zig").ApplicationResourceLifecycleConfig;
const serde = @import("serde.zig");

pub const UpdateApplicationResourceLifecycleInput = struct {
    /// The name of the application.
    application_name: []const u8,

    /// The lifecycle configuration.
    resource_lifecycle_config: ApplicationResourceLifecycleConfig,
};

pub const UpdateApplicationResourceLifecycleOutput = struct {
    /// The name of the application.
    application_name: ?[]const u8 = null,

    /// The lifecycle configuration.
    resource_lifecycle_config: ?ApplicationResourceLifecycleConfig = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationResourceLifecycleInput, options: CallOptions) !UpdateApplicationResourceLifecycleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationResourceLifecycleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateApplicationResourceLifecycle&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ApplicationName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.application_name);
    if (input.resource_lifecycle_config.service_role) |sv| {
        try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.ServiceRole=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.resource_lifecycle_config.version_lifecycle_config) |sv| {
        if (sv.max_age_rule) |sv2| {
            if (sv2.delete_source_from_s3) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxAgeRule.DeleteSourceFromS3=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv3) "true" else "false");
            }
            try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxAgeRule.Enabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2.enabled) "true" else "false");
            if (sv2.max_age_in_days) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxAgeRule.MaxAgeInDays=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
            }
        }
        if (sv.max_count_rule) |sv2| {
            if (sv2.delete_source_from_s3) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxCountRule.DeleteSourceFromS3=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv3) "true" else "false");
            }
            try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxCountRule.Enabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2.enabled) "true" else "false");
            if (sv2.max_count) |sv3| {
                try body_buf.appendSlice(allocator, "&ResourceLifecycleConfig.VersionLifecycleConfig.MaxCountRule.MaxCount=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationResourceLifecycleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateApplicationResourceLifecycleResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateApplicationResourceLifecycleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplicationName")) {
                    result.application_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceLifecycleConfig")) {
                    result.resource_lifecycle_config = try serde.deserializeApplicationResourceLifecycleConfig(allocator, &reader);
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
