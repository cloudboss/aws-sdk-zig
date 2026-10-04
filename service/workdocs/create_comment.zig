const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommentVisibilityType = @import("comment_visibility_type.zig").CommentVisibilityType;
const Comment = @import("comment.zig").Comment;

pub const CreateCommentInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// The ID of the document.
    document_id: []const u8,

    /// Set this parameter to TRUE to send an email out to the document
    /// collaborators after
    /// the comment is created.
    notify_collaborators: ?bool = null,

    /// The ID of the parent comment.
    parent_id: ?[]const u8 = null,

    /// The text of the comment.
    text: []const u8,

    /// The ID of the root comment in the thread.
    thread_id: ?[]const u8 = null,

    /// The ID of the document version.
    version_id: []const u8,

    /// The visibility of the comment. Options are either PRIVATE, where the comment
    /// is
    /// visible only to the comment author and document owner and co-owners, or
    /// PUBLIC, where
    /// the comment is visible to document owners, co-owners, and contributors.
    visibility: ?CommentVisibilityType = null,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .document_id = "DocumentId",
        .notify_collaborators = "NotifyCollaborators",
        .parent_id = "ParentId",
        .text = "Text",
        .thread_id = "ThreadId",
        .version_id = "VersionId",
        .visibility = "Visibility",
    };
};

pub const CreateCommentOutput = struct {
    /// The comment that has been created.
    comment: ?Comment = null,

    pub const json_field_names = .{
        .comment = "Comment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCommentInput, options: CallOptions) !CreateCommentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCommentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/documents/");
    try path_buf.appendSlice(allocator, input.document_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_id);
    try path_buf.appendSlice(allocator, "/comment");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.notify_collaborators) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NotifyCollaborators\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Text\":");
    try aws.json.writeValue(@TypeOf(input.text), input.text, allocator, &body_buf);
    has_prev = true;
    if (input.thread_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ThreadId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.visibility) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Visibility\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCommentOutput {
    const result: CreateCommentOutput = try aws.json.parseJsonObject(
        CreateCommentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
