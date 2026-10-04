const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteOptedOutNumberInput = struct {
    /// The phone number, in E.164 format, to remove from the OptOutList.
    opted_out_number: []const u8,

    /// The OptOutListName or OptOutListArn to remove the phone number from.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    opt_out_list_name: []const u8,

    pub const json_field_names = .{
        .opted_out_number = "OptedOutNumber",
        .opt_out_list_name = "OptOutListName",
    };
};

pub const DeleteOptedOutNumberOutput = struct {
    /// This is true if it was the end user who requested their phone number be
    /// removed.
    end_user_opted_out: ?bool = null,

    /// The phone number that was removed from the OptOutList.
    opted_out_number: ?[]const u8 = null,

    /// The time that the number was removed at, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    opted_out_timestamp: ?i64 = null,

    /// The OptOutListArn that the phone number was removed from.
    opt_out_list_arn: ?[]const u8 = null,

    /// The OptOutListName that the phone number was removed from.
    opt_out_list_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_user_opted_out = "EndUserOptedOut",
        .opted_out_number = "OptedOutNumber",
        .opted_out_timestamp = "OptedOutTimestamp",
        .opt_out_list_arn = "OptOutListArn",
        .opt_out_list_name = "OptOutListName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteOptedOutNumberInput, options: CallOptions) !DeleteOptedOutNumberOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteOptedOutNumberInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteOptedOutNumber");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteOptedOutNumberOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteOptedOutNumberOutput, body, allocator);
}
