const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateLabelGroupInput = struct {
    /// A unique identifier for the request to create a label group. If you do not
    /// set the
    /// client request token, Lookout for Equipment generates one.
    client_token: []const u8,

    /// The acceptable fault codes (indicating the type of anomaly associated with
    /// the label)
    /// that can be used with this label group.
    ///
    /// Data in this field will be retained for service usage. Follow best practices
    /// for the
    /// security of your data.
    fault_codes: ?[]const []const u8 = null,

    /// Names a group of labels.
    ///
    /// Data in this field will be retained for service usage. Follow best practices
    /// for the
    /// security of your data.
    label_group_name: []const u8,

    /// Tags that provide metadata about the label group you are creating.
    ///
    /// Data in this field will be retained for service usage. Follow best practices
    /// for the
    /// security of your data.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .fault_codes = "FaultCodes",
        .label_group_name = "LabelGroupName",
        .tags = "Tags",
    };
};

pub const CreateLabelGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the label group that you have created.
    label_group_arn: ?[]const u8 = null,

    /// The name of the label group that you have created. Data in this field will
    /// be retained
    /// for service usage. Follow best practices for the security of your data.
    label_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .label_group_arn = "LabelGroupArn",
        .label_group_name = "LabelGroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLabelGroupInput, options: CallOptions) !CreateLabelGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLabelGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.CreateLabelGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLabelGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLabelGroupOutput, body, allocator);
}
