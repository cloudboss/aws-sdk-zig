const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListFlowAssociationResourceType = @import("list_flow_association_resource_type.zig").ListFlowAssociationResourceType;
const FlowAssociationSummary = @import("flow_association_summary.zig").FlowAssociationSummary;

pub const BatchGetFlowAssociationInput = struct {
    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// A list of resource identifiers to retrieve flow associations.
    ///
    /// * Amazon Web Services End User Messaging SMS phone number ARN when using
    ///   `SMS_PHONE_NUMBER`
    ///
    /// * Amazon Web Services End User Messaging Social phone number ARN when using
    /// `WHATSAPP_MESSAGING_PHONE_NUMBER`
    resource_ids: []const []const u8,

    /// The type of resource association.
    resource_type: ?ListFlowAssociationResourceType = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .resource_ids = "ResourceIds",
        .resource_type = "ResourceType",
    };
};

pub const BatchGetFlowAssociationOutput = struct {
    /// Information about flow associations.
    flow_association_summary_list: ?[]const FlowAssociationSummary = null,

    pub const json_field_names = .{
        .flow_association_summary_list = "FlowAssociationSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetFlowAssociationInput, options: CallOptions) !BatchGetFlowAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetFlowAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flow-associations-batch/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceIds\":");
    try aws.json.writeValue(@TypeOf(input.resource_ids), input.resource_ids, allocator, &body_buf);
    has_prev = true;
    if (input.resource_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetFlowAssociationOutput {
    const result: BatchGetFlowAssociationOutput = try aws.json.parseJsonObject(
        BatchGetFlowAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
