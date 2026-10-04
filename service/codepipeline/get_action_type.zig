const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActionCategory = @import("action_category.zig").ActionCategory;
const ActionTypeDeclaration = @import("action_type_declaration.zig").ActionTypeDeclaration;

pub const GetActionTypeInput = struct {
    /// Defines what kind of action can be taken in the stage. The following are the
    /// valid
    /// values:
    ///
    /// * `Source`
    ///
    /// * `Build`
    ///
    /// * `Test`
    ///
    /// * `Deploy`
    ///
    /// * `Approval`
    ///
    /// * `Invoke`
    ///
    /// * `Compute`
    category: ActionCategory,

    /// The creator of an action type that was created with any supported
    /// integration model.
    /// There are two valid values: `AWS` and `ThirdParty`.
    owner: []const u8,

    /// The provider of the action type being called. The provider name is specified
    /// when the
    /// action type is created.
    provider: []const u8,

    /// A string that describes the action type version.
    version: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .owner = "owner",
        .provider = "provider",
        .version = "version",
    };
};

pub const GetActionTypeOutput = struct {
    /// The action type information for the requested action type, such as the
    /// action type
    /// ID.
    action_type: ?ActionTypeDeclaration = null,

    pub const json_field_names = .{
        .action_type = "actionType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetActionTypeInput, options: CallOptions) !GetActionTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetActionTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.GetActionType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetActionTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetActionTypeOutput, body, allocator);
}
