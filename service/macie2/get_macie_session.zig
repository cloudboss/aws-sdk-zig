const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingPublishingFrequency = @import("finding_publishing_frequency.zig").FindingPublishingFrequency;
const MacieStatus = @import("macie_status.zig").MacieStatus;

pub const GetMacieSessionInput = struct {
};

pub const GetMacieSessionOutput = struct {
    /// The date and time, in UTC and extended ISO 8601 format, when the Amazon
    /// Macie account was created.
    created_at: ?i64 = null,

    /// The frequency with which Amazon Macie publishes updates to policy findings
    /// for the account. This includes publishing updates to Security Hub and Amazon
    /// EventBridge (formerly Amazon CloudWatch Events).
    finding_publishing_frequency: ?FindingPublishingFrequency = null,

    /// The Amazon Resource Name (ARN) of the service-linked role that allows Amazon
    /// Macie to monitor and analyze data in Amazon Web Services resources for the
    /// account.
    service_role: ?[]const u8 = null,

    /// The current status of the Amazon Macie account. Possible values are: PAUSED,
    /// the account is enabled but all Macie activities are suspended (paused) for
    /// the account; and, ENABLED, the account is enabled and all Macie activities
    /// are enabled for the account.
    status: ?MacieStatus = null,

    /// The date and time, in UTC and extended ISO 8601 format, of the most recent
    /// change to the status or configuration settings for the Amazon Macie account.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .finding_publishing_frequency = "findingPublishingFrequency",
        .service_role = "serviceRole",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMacieSessionInput, options: CallOptions) !GetMacieSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMacieSessionInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/macie";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMacieSessionOutput {
    var result: GetMacieSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMacieSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
