const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendedActionUpdate = @import("recommended_action_update.zig").RecommendedActionUpdate;
const DBRecommendation = @import("db_recommendation.zig").DBRecommendation;
const serde = @import("serde.zig");

pub const ModifyDBRecommendationInput = struct {
    /// The language of the modified recommendation.
    locale: ?[]const u8 = null,

    /// The identifier of the recommendation to update.
    recommendation_id: []const u8,

    /// The list of recommended action status to update. You can update multiple
    /// recommended actions at one time.
    recommended_action_updates: ?[]const RecommendedActionUpdate = null,

    /// The recommendation status to update.
    ///
    /// Valid values:
    ///
    /// * active
    /// * dismissed
    status: ?[]const u8 = null,
};

pub const ModifyDBRecommendationOutput = struct {
    db_recommendation: ?DBRecommendation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBRecommendationInput, options: CallOptions) !ModifyDBRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBRecommendation&Version=2014-10-31");
    if (input.locale) |v| {
        try body_buf.appendSlice(allocator, "&Locale=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RecommendationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.recommendation_id);
    if (input.recommended_action_updates) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RecommendedActionUpdates.member.{d}.ActionId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.action_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RecommendedActionUpdates.member.{d}.Status=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.status);
            }
        }
    }
    if (input.status) |v| {
        try body_buf.appendSlice(allocator, "&Status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBRecommendationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBRecommendationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBRecommendationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBRecommendation")) {
                    result.db_recommendation = try serde.deserializeDBRecommendation(allocator, &reader);
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
