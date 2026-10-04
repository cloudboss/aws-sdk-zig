const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SwapEnvironmentCNAMEsInput = struct {
    /// The ID of the destination environment.
    ///
    /// Condition: You must specify at least the `DestinationEnvironmentID` or the
    /// `DestinationEnvironmentName`. You may also specify both. You must specify
    /// the
    /// `SourceEnvironmentId` with the `DestinationEnvironmentId`.
    destination_environment_id: ?[]const u8 = null,

    /// The name of the destination environment.
    ///
    /// Condition: You must specify at least the `DestinationEnvironmentID` or the
    /// `DestinationEnvironmentName`. You may also specify both. You must specify
    /// the
    /// `SourceEnvironmentName` with the `DestinationEnvironmentName`.
    destination_environment_name: ?[]const u8 = null,

    /// The ID of the source environment.
    ///
    /// Condition: You must specify at least the `SourceEnvironmentID` or the
    /// `SourceEnvironmentName`. You may also specify both. If you specify the
    /// `SourceEnvironmentId`, you must specify the
    /// `DestinationEnvironmentId`.
    source_environment_id: ?[]const u8 = null,

    /// The name of the source environment.
    ///
    /// Condition: You must specify at least the `SourceEnvironmentID` or the
    /// `SourceEnvironmentName`. You may also specify both. If you specify the
    /// `SourceEnvironmentName`, you must specify the
    /// `DestinationEnvironmentName`.
    source_environment_name: ?[]const u8 = null,
};

pub const SwapEnvironmentCNAMEsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SwapEnvironmentCNAMEsInput, options: CallOptions) !SwapEnvironmentCNAMEsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SwapEnvironmentCNAMEsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticbeanstalk", "Elastic Beanstalk", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SwapEnvironmentCNAMEs&Version=2010-12-01");
    if (input.destination_environment_id) |v| {
        try body_buf.appendSlice(allocator, "&DestinationEnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_environment_name) |v| {
        try body_buf.appendSlice(allocator, "&DestinationEnvironmentName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_environment_id) |v| {
        try body_buf.appendSlice(allocator, "&SourceEnvironmentId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_environment_name) |v| {
        try body_buf.appendSlice(allocator, "&SourceEnvironmentName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SwapEnvironmentCNAMEsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SwapEnvironmentCNAMEsOutput = .{};

    return result;
}
