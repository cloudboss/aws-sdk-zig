const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnvironmentInfoType = @import("environment_info_type.zig").EnvironmentInfoType;
const EnvironmentInfoDescription = @import("environment_info_description.zig").EnvironmentInfoDescription;
const serde = @import("serde.zig");

pub const RetrieveEnvironmentInfoInput = struct {
    /// The ID of the data's environment.
    ///
    /// If no such environment is found, returns an `InvalidParameterValue` error.
    ///
    /// Condition: You must specify either this or an EnvironmentName, or both. If
    /// you do not specify either, Elastic Beanstalk returns
    /// `MissingRequiredParameter` error.
    environment_id: ?[]const u8 = null,

    /// The name of the data's environment.
    ///
    /// If no such environment is found, returns an `InvalidParameterValue` error.
    ///
    /// Condition: You must specify either this or an EnvironmentId, or both. If you
    /// do not specify either, Elastic Beanstalk returns
    /// `MissingRequiredParameter` error.
    environment_name: ?[]const u8 = null,

    /// The type of information to retrieve.
    info_type: EnvironmentInfoType,
};

pub const RetrieveEnvironmentInfoOutput = struct {
    /// The EnvironmentInfoDescription of the environment.
    environment_info: ?[]const EnvironmentInfoDescription = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveEnvironmentInfoInput, options: CallOptions) !RetrieveEnvironmentInfoOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveEnvironmentInfoInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RetrieveEnvironmentInfo&Version=2010-12-01");
    if (input.environment_id) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.environment_name) |v| {
        try body_buf.appendSlice(allocator, "&EnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&InfoType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.info_type.wireName());

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveEnvironmentInfoOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RetrieveEnvironmentInfoResult")) break;
            },
            else => {},
        }
    }

    var result: RetrieveEnvironmentInfoOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnvironmentInfo")) {
                    result.environment_info = try serde.deserializeEnvironmentInfoDescriptionList(allocator, &reader, "member");
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
