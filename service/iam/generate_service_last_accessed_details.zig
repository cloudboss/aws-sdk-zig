const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessAdvisorUsageGranularityType = @import("access_advisor_usage_granularity_type.zig").AccessAdvisorUsageGranularityType;

pub const GenerateServiceLastAccessedDetailsInput = struct {
    /// The ARN of the IAM resource (user, group, role, or managed policy) used to
    /// generate
    /// information about when the resource was last used in an attempt to access an
    /// Amazon Web Services
    /// service.
    arn: []const u8,

    /// The level of detail that you want to generate. You can specify whether you
    /// want to
    /// generate information about the last attempt to access services or actions.
    /// If you
    /// specify service-level granularity, this operation generates only service
    /// data. If you
    /// specify action-level granularity, it generates service and action data. If
    /// you don't
    /// include this optional parameter, the operation generates service data.
    granularity: ?AccessAdvisorUsageGranularityType = null,
};

pub const GenerateServiceLastAccessedDetailsOutput = struct {
    /// The `JobId` that you can use in the
    /// [GetServiceLastAccessedDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetails.html) or [GetServiceLastAccessedDetailsWithEntities](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetServiceLastAccessedDetailsWithEntities.html) operations. The
    /// `JobId` returned by `GenerateServiceLastAccessedDetail` must
    /// be used by the same role within a session, or by the same user when used to
    /// call
    /// `GetServiceLastAccessedDetail`.
    job_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateServiceLastAccessedDetailsInput, options: CallOptions) !GenerateServiceLastAccessedDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateServiceLastAccessedDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GenerateServiceLastAccessedDetails&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&Arn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.arn);
    if (input.granularity) |v| {
        try body_buf.appendSlice(allocator, "&Granularity=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateServiceLastAccessedDetailsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GenerateServiceLastAccessedDetailsResult")) break;
            },
            else => {},
        }
    }

    var result: GenerateServiceLastAccessedDetailsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try allocator.dupe(u8, try reader.readElementText());
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
