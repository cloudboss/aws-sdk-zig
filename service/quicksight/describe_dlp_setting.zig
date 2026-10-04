const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DlpSettingDetails = @import("dlp_setting_details.zig").DlpSettingDetails;

pub const DescribeDlpSettingInput = struct {
    /// The ID of the Amazon Web Services account that contains the DLP setting that
    /// you want to describe.
    aws_account_id: []const u8,

    /// The ID of the DLP setting that you want to describe.
    dlp_setting_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dlp_setting_id = "DlpSettingId",
    };
};

pub const DescribeDlpSettingOutput = struct {
    /// The full configuration of the requested DLP setting, returned as a
    /// `DlpSettingDetails` object.
    dlp_setting: ?DlpSettingDetails = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dlp_setting = "DlpSetting",
        .request_id = "RequestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDlpSettingInput, options: CallOptions) !DescribeDlpSettingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDlpSettingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/data-loss-prevention/settings/");
    try path_buf.appendSlice(allocator, input.dlp_setting_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDlpSettingOutput {
    const result: DescribeDlpSettingOutput = try aws.json.parseJsonObject(
        DescribeDlpSettingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
