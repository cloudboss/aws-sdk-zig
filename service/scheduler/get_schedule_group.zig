const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScheduleGroupState = @import("schedule_group_state.zig").ScheduleGroupState;

pub const GetScheduleGroupInput = struct {
    /// The name of the schedule group to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetScheduleGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the schedule group.
    arn: ?[]const u8 = null,

    /// The time at which the schedule group was created.
    creation_date: ?i64 = null,

    /// The time at which the schedule group was last modified.
    last_modification_date: ?i64 = null,

    /// The name of the schedule group.
    name: ?[]const u8 = null,

    /// Specifies the state of the schedule group.
    state: ?ScheduleGroupState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .last_modification_date = "LastModificationDate",
        .name = "Name",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScheduleGroupInput, options: CallOptions) !GetScheduleGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scheduler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetScheduleGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scheduler", "Scheduler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/schedule-groups/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScheduleGroupOutput {
    var result: GetScheduleGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetScheduleGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
