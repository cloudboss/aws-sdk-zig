const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollaborationAnalysisTemplate = @import("collaboration_analysis_template.zig").CollaborationAnalysisTemplate;

pub const GetCollaborationAnalysisTemplateInput = struct {
    /// The Amazon Resource Name (ARN) associated with the analysis template within
    /// a collaboration.
    analysis_template_arn: []const u8,

    /// A unique identifier for the collaboration that the analysis templates belong
    /// to. Currently accepts collaboration ID.
    collaboration_identifier: []const u8,

    pub const json_field_names = .{
        .analysis_template_arn = "analysisTemplateArn",
        .collaboration_identifier = "collaborationIdentifier",
    };
};

pub const GetCollaborationAnalysisTemplateOutput = struct {
    /// The analysis template within a collaboration.
    collaboration_analysis_template: ?CollaborationAnalysisTemplate = null,

    pub const json_field_names = .{
        .collaboration_analysis_template = "collaborationAnalysisTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCollaborationAnalysisTemplateInput, options: CallOptions) !GetCollaborationAnalysisTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCollaborationAnalysisTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/analysistemplates/");
    try path_buf.appendSlice(allocator, input.analysis_template_arn);
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCollaborationAnalysisTemplateOutput {
    const result: GetCollaborationAnalysisTemplateOutput = try aws.json.parseJsonObject(
        GetCollaborationAnalysisTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
