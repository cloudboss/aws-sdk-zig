const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PreviewPrivacyImpactParametersInput = @import("preview_privacy_impact_parameters_input.zig").PreviewPrivacyImpactParametersInput;
const PrivacyImpact = @import("privacy_impact.zig").PrivacyImpact;

pub const PreviewPrivacyImpactInput = struct {
    /// A unique identifier for one of your memberships for a collaboration. Accepts
    /// a membership ID.
    membership_identifier: []const u8,

    /// Specifies the desired epsilon and noise parameters to preview.
    parameters: PreviewPrivacyImpactParametersInput,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .parameters = "parameters",
    };
};

pub const PreviewPrivacyImpactOutput = struct {
    /// An estimate of the number of aggregation functions that the member who can
    /// query can run given the epsilon and noise parameters. This does not change
    /// the privacy budget.
    privacy_impact: ?PrivacyImpact = null,

    pub const json_field_names = .{
        .privacy_impact = "privacyImpact",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PreviewPrivacyImpactInput, options: CallOptions) !PreviewPrivacyImpactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PreviewPrivacyImpactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/previewprivacyimpact");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"parameters\":");
    try aws.json.writeValue(@TypeOf(input.parameters), input.parameters, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PreviewPrivacyImpactOutput {
    var result: PreviewPrivacyImpactOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PreviewPrivacyImpactOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
