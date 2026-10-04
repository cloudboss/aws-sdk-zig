const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListUpdateMode = @import("list_update_mode.zig").ListUpdateMode;

pub const UpdateListInput = struct {
    /// The new description.
    description: ?[]const u8 = null,

    /// One or more list elements to add or replace. If you are providing the
    /// elements, make sure to specify the `updateMode` to use.
    ///
    /// If you are deleting all elements from the list, use `REPLACE` for the
    /// `updateMode` and provide an empty list (0 elements).
    elements: ?[]const []const u8 = null,

    /// The name of the list to update.
    name: []const u8,

    /// The update mode (type).
    ///
    /// * Use `APPEND` if you are adding elements to the list.
    ///
    /// * Use `REPLACE` if you replacing existing elements in the list.
    ///
    /// * Use `REMOVE` if you are removing elements from the list.
    update_mode: ?ListUpdateMode = null,

    /// The variable type you want to assign to the list.
    ///
    /// You cannot update a variable type of a list that already has a variable type
    /// assigned to it. You can assign a variable type to a list only if the list
    /// does not already have a variable type.
    variable_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .elements = "elements",
        .name = "name",
        .update_mode = "updateMode",
        .variable_type = "variableType",
    };
};

pub const UpdateListOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateListInput, options: CallOptions) !UpdateListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.UpdateList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateListOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
