const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteTemplateAliasInput = struct {
    /// The name for the template alias. To delete a specific alias, you delete the
    /// version that the
    /// alias points to. You can specify the alias name, or specify the latest
    /// version of the
    /// template by providing the keyword `$LATEST` in the `AliasName`
    /// parameter.
    alias_name: []const u8,

    /// The ID of the Amazon Web Services account that contains the item to delete.
    aws_account_id: []const u8,

    /// The ID for the template that the specified alias is for.
    template_id: []const u8,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .aws_account_id = "AwsAccountId",
        .template_id = "TemplateId",
    };
};

pub const DeleteTemplateAliasOutput = struct {
    /// The name for the template alias.
    alias_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the template you want to delete.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// An ID for the template associated with the deletion.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .arn = "Arn",
        .request_id = "RequestId",
        .status = "Status",
        .template_id = "TemplateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteTemplateAliasInput, options: CallOptions) !DeleteTemplateAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteTemplateAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.alias_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteTemplateAliasOutput {
    var result: DeleteTemplateAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteTemplateAliasOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
