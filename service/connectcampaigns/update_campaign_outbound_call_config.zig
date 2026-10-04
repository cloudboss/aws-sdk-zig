const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnswerMachineDetectionConfig = @import("answer_machine_detection_config.zig").AnswerMachineDetectionConfig;

pub const UpdateCampaignOutboundCallConfigInput = struct {
    answer_machine_detection_config: ?AnswerMachineDetectionConfig = null,

    connect_contact_flow_id: ?[]const u8 = null,

    connect_source_phone_number: ?[]const u8 = null,

    id: []const u8,

    pub const json_field_names = .{
        .answer_machine_detection_config = "answerMachineDetectionConfig",
        .connect_contact_flow_id = "connectContactFlowId",
        .connect_source_phone_number = "connectSourcePhoneNumber",
        .id = "id",
    };
};

pub const UpdateCampaignOutboundCallConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCampaignOutboundCallConfigInput, options: CallOptions) !UpdateCampaignOutboundCallConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect-campaigns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCampaignOutboundCallConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect-campaigns", "ConnectCampaigns", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/campaigns/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/outbound-call-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.answer_machine_detection_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"answerMachineDetectionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connect_contact_flow_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectContactFlowId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connect_source_phone_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectSourcePhoneNumber\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCampaignOutboundCallConfigOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateCampaignOutboundCallConfigOutput = .{};

    return result;
}
