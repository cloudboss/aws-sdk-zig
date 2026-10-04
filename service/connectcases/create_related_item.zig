const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RelatedItemInputContent = @import("related_item_input_content.zig").RelatedItemInputContent;
const UserUnion = @import("user_union.zig").UserUnion;
const RelatedItemType = @import("related_item_type.zig").RelatedItemType;

pub const CreateRelatedItemInput = struct {
    /// A unique identifier of the case.
    case_id: []const u8,

    /// The content of a related item to be created.
    content: RelatedItemInputContent,

    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// Represents the creator of the related item.
    performed_by: ?UserUnion = null,

    /// The type of a related item.
    @"type": RelatedItemType,

    pub const json_field_names = .{
        .case_id = "caseId",
        .content = "content",
        .domain_id = "domainId",
        .performed_by = "performedBy",
        .@"type" = "type",
    };
};

pub const CreateRelatedItemOutput = struct {
    /// The Amazon Resource Name (ARN) of the related item.
    related_item_arn: []const u8,

    /// The unique identifier of the related item.
    related_item_id: []const u8,

    pub const json_field_names = .{
        .related_item_arn = "relatedItemArn",
        .related_item_id = "relatedItemId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRelatedItemInput, options: CallOptions) !CreateRelatedItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cases", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRelatedItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cases", "ConnectCases", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/related-items/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.performed_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"performedBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRelatedItemOutput {
    const result: CreateRelatedItemOutput = try aws.json.parseJsonObject(
        CreateRelatedItemOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
