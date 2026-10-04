const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingPublishingFrequency = @import("finding_publishing_frequency.zig").FindingPublishingFrequency;
const MacieStatus = @import("macie_status.zig").MacieStatus;

pub const UpdateMacieSessionInput = struct {
    /// Specifies how often to publish updates to policy findings for the account.
    /// This includes publishing updates to Security Hub and Amazon EventBridge
    /// (formerly Amazon CloudWatch Events).
    finding_publishing_frequency: ?FindingPublishingFrequency = null,

    /// Specifies a new status for the account. Valid values are: ENABLED, resume
    /// all Amazon Macie activities for the account; and, PAUSED, suspend all Macie
    /// activities for the account.
    status: ?MacieStatus = null,

    pub const json_field_names = .{
        .finding_publishing_frequency = "findingPublishingFrequency",
        .status = "status",
    };
};

pub const UpdateMacieSessionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMacieSessionInput, options: CallOptions) !UpdateMacieSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMacieSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/macie";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.finding_publishing_frequency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"findingPublishingFrequency\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMacieSessionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateMacieSessionOutput = .{};

    return result;
}
