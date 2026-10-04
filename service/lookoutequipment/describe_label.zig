const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LabelRating = @import("label_rating.zig").LabelRating;

pub const DescribeLabelInput = struct {
    /// Returns the name of the group containing the label.
    label_group_name: []const u8,

    /// Returns the ID of the label.
    label_id: []const u8,

    pub const json_field_names = .{
        .label_group_name = "LabelGroupName",
        .label_id = "LabelId",
    };
};

pub const DescribeLabelOutput = struct {
    /// The time at which the label was created.
    created_at: ?i64 = null,

    /// The end time of the requested label.
    end_time: ?i64 = null,

    /// Indicates that a label pertains to a particular piece of equipment.
    equipment: ?[]const u8 = null,

    /// Indicates the type of anomaly associated with the label.
    ///
    /// Data in this field will be retained for service usage. Follow best practices
    /// for the
    /// security of your data.
    fault_code: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the requested label group.
    label_group_arn: ?[]const u8 = null,

    /// The name of the requested label group.
    label_group_name: ?[]const u8 = null,

    /// The ID of the requested label.
    label_id: ?[]const u8 = null,

    /// Metadata providing additional information about the label.
    ///
    /// Data in this field will be retained for service usage. Follow best practices
    /// for the
    /// security of your data.
    notes: ?[]const u8 = null,

    /// Indicates whether a labeled event represents an anomaly.
    rating: ?LabelRating = null,

    /// The start time of the requested label.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .end_time = "EndTime",
        .equipment = "Equipment",
        .fault_code = "FaultCode",
        .label_group_arn = "LabelGroupArn",
        .label_group_name = "LabelGroupName",
        .label_id = "LabelId",
        .notes = "Notes",
        .rating = "Rating",
        .start_time = "StartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLabelInput, options: CallOptions) !DescribeLabelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLabelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeLabel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLabelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLabelOutput, body, allocator);
}
