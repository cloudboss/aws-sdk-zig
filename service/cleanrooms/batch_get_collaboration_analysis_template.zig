const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CollaborationAnalysisTemplate = @import("collaboration_analysis_template.zig").CollaborationAnalysisTemplate;
const BatchGetCollaborationAnalysisTemplateError = @import("batch_get_collaboration_analysis_template_error.zig").BatchGetCollaborationAnalysisTemplateError;

pub const BatchGetCollaborationAnalysisTemplateInput = struct {
    /// The Amazon Resource Name (ARN) associated with the analysis template within
    /// a collaboration.
    analysis_template_arns: []const []const u8,

    /// A unique identifier for the collaboration that the analysis templates belong
    /// to. Currently accepts collaboration ID.
    collaboration_identifier: []const u8,

    pub const json_field_names = .{
        .analysis_template_arns = "analysisTemplateArns",
        .collaboration_identifier = "collaborationIdentifier",
    };
};

pub const BatchGetCollaborationAnalysisTemplateOutput = struct {
    /// The retrieved list of analysis templates within a collaboration.
    collaboration_analysis_templates: ?[]const CollaborationAnalysisTemplate = null,

    /// Error reasons for collaboration analysis templates that could not be
    /// retrieved. One error is returned for every collaboration analysis template
    /// that could not be retrieved.
    errors: ?[]const BatchGetCollaborationAnalysisTemplateError = null,

    pub const json_field_names = .{
        .collaboration_analysis_templates = "collaborationAnalysisTemplates",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCollaborationAnalysisTemplateInput, options: CallOptions) !BatchGetCollaborationAnalysisTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCollaborationAnalysisTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/batch-analysistemplates");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisTemplateArns\":");
    try aws.json.writeValue(@TypeOf(input.analysis_template_arns), input.analysis_template_arns, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCollaborationAnalysisTemplateOutput {
    const result: BatchGetCollaborationAnalysisTemplateOutput = try aws.json.parseJsonObject(
        BatchGetCollaborationAnalysisTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
