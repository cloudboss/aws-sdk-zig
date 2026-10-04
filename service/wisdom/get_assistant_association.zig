const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssistantAssociationData = @import("assistant_association_data.zig").AssistantAssociationData;

pub const GetAssistantAssociationInput = struct {
    /// The identifier of the assistant association. Can be either the ID or the
    /// ARN. URLs cannot contain the ARN.
    assistant_association_id: []const u8,

    /// The identifier of the Wisdom assistant. Can be either the ID or the ARN.
    /// URLs cannot contain the ARN.
    assistant_id: []const u8,

    pub const json_field_names = .{
        .assistant_association_id = "assistantAssociationId",
        .assistant_id = "assistantId",
    };
};

pub const GetAssistantAssociationOutput = struct {
    /// The assistant association.
    assistant_association: ?AssistantAssociationData = null,

    pub const json_field_names = .{
        .assistant_association = "assistantAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssistantAssociationInput, options: CallOptions) !GetAssistantAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssistantAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "Wisdom", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/associations/");
    try path_buf.appendSlice(allocator, input.assistant_association_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssistantAssociationOutput {
    const result: GetAssistantAssociationOutput = try aws.json.parseJsonObject(
        GetAssistantAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
