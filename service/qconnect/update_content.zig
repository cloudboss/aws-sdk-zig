const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentData = @import("content_data.zig").ContentData;

pub const UpdateContentInput = struct {
    /// The identifier of the content. Can be either the ID or the ARN. URLs cannot
    /// contain the ARN.
    content_id: []const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge base. Can be either the ID or the ARN
    knowledge_base_id: []const u8,

    /// A key/value map to store attributes without affecting tagging or
    /// recommendations. For example, when synchronizing data between an external
    /// system and Amazon Q in Connect, you can store an external version identifier
    /// as metadata to utilize for determining drift.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The URI for the article. If the knowledge base has a templateUri, setting
    /// this argument overrides it for this piece of content. To remove an existing
    /// `overrideLinkOurUri`, exclude this argument and set
    /// `removeOverrideLinkOutUri` to true.
    override_link_out_uri: ?[]const u8 = null,

    /// Unset the existing `overrideLinkOutUri` if it exists.
    remove_override_link_out_uri: ?bool = null,

    /// The `revisionId` of the content resource to update, taken from an earlier
    /// call to `GetContent`, `GetContentSummary`, `SearchContent`, or
    /// `ListContents`. If included, this argument acts as an optimistic lock to
    /// ensure content was not modified since it was last read. If it has been
    /// modified, this API throws a `PreconditionFailedException`.
    revision_id: ?[]const u8 = null,

    /// The title of the content.
    title: ?[]const u8 = null,

    /// A pointer to the uploaded asset. This value is returned by
    /// [StartContentUpload](https://docs.aws.amazon.com/amazon-q-connect/latest/APIReference/API_StartContentUpload.html).
    upload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_id = "contentId",
        .knowledge_base_id = "knowledgeBaseId",
        .metadata = "metadata",
        .override_link_out_uri = "overrideLinkOutUri",
        .remove_override_link_out_uri = "removeOverrideLinkOutUri",
        .revision_id = "revisionId",
        .title = "title",
        .upload_id = "uploadId",
    };
};

pub const UpdateContentOutput = struct {
    /// The content.
    content: ?ContentData = null,

    pub const json_field_names = .{
        .content = "content",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContentInput, options: CallOptions) !UpdateContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/contents/");
    try path_buf.appendSlice(allocator, input.content_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.override_link_out_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"overrideLinkOutUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_override_link_out_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"removeOverrideLinkOutUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"revisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"title\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.upload_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"uploadId\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContentOutput {
    const result: UpdateContentOutput = try aws.json.parseJsonObject(
        UpdateContentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
