const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisTemplate = @import("analysis_template.zig").AnalysisTemplate;

pub const UpdateAnalysisTemplateInput = struct {
    /// The identifier for the analysis template resource.
    analysis_template_identifier: []const u8,

    /// A new description for the analysis template.
    description: ?[]const u8 = null,

    /// The identifier for a membership resource.
    membership_identifier: []const u8,

    pub const json_field_names = .{
        .analysis_template_identifier = "analysisTemplateIdentifier",
        .description = "description",
        .membership_identifier = "membershipIdentifier",
    };
};

pub const UpdateAnalysisTemplateOutput = struct {
    /// The analysis template.
    analysis_template: ?AnalysisTemplate = null,

    pub const json_field_names = .{
        .analysis_template = "analysisTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAnalysisTemplateInput, options: CallOptions) !UpdateAnalysisTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAnalysisTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/analysistemplates/");
    try path_buf.appendSlice(allocator, input.analysis_template_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAnalysisTemplateOutput {
    var result: UpdateAnalysisTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAnalysisTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
