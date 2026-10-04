const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingCriteriaInput = @import("routing_criteria_input.zig").RoutingCriteriaInput;

pub const UpdateContactRoutingDataInput = struct {
    /// The identifier of the contact in this instance of Connect Customer.
    contact_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// Priority of the contact in the queue. The default priority for new contacts
    /// is 5. You can raise the priority of
    /// a contact compared to other contacts in the queue by assigning them a higher
    /// priority, such as 1 or 2.
    queue_priority: ?i64 = null,

    /// The number of seconds to add or subtract from the contact's routing age.
    /// Contacts are routed to agents on a
    /// first-come, first-serve basis. This means that changing their amount of time
    /// in queue compared to others also changes
    /// their position in queue.
    queue_time_adjustment_seconds: ?i32 = null,

    /// Updates the routing criteria on the contact. These properties can be used to
    /// change how a contact is routed
    /// within the queue.
    routing_criteria: ?RoutingCriteriaInput = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .instance_id = "InstanceId",
        .queue_priority = "QueuePriority",
        .queue_time_adjustment_seconds = "QueueTimeAdjustmentSeconds",
        .routing_criteria = "RoutingCriteria",
    };
};

pub const UpdateContactRoutingDataOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContactRoutingDataInput, options: CallOptions) !UpdateContactRoutingDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContactRoutingDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contacts/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.contact_id);
    try path_buf.appendSlice(allocator, "/routing-data");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.queue_priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueuePriority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.queue_time_adjustment_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueueTimeAdjustmentSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.routing_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoutingCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContactRoutingDataOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateContactRoutingDataOutput = .{};

    return result;
}
