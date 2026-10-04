const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LabelSummary = @import("label_summary.zig").LabelSummary;

pub const ListLabelsInput = struct {
    /// Lists the labels that pertain to a particular piece of equipment.
    equipment: ?[]const u8 = null,

    /// Returns labels with a particular fault code.
    fault_code: ?[]const u8 = null,

    /// Returns all labels with a start time earlier than the end time given.
    interval_end_time: ?i64 = null,

    /// Returns all the labels with a end time equal to or later than the start time
    /// given.
    interval_start_time: ?i64 = null,

    /// Returns the name of the label group.
    label_group_name: []const u8,

    /// Specifies the maximum number of labels to list.
    max_results: ?i32 = null,

    /// An opaque pagination token indicating where to continue the listing of label
    /// groups.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .equipment = "Equipment",
        .fault_code = "FaultCode",
        .interval_end_time = "IntervalEndTime",
        .interval_start_time = "IntervalStartTime",
        .label_group_name = "LabelGroupName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListLabelsOutput = struct {
    /// A summary of the items in the label group.
    ///
    /// If you don't supply the `LabelGroupName` request parameter, or if you supply
    /// the name of a label group that doesn't exist, `ListLabels` returns an empty
    /// array in
    /// `LabelSummaries`.
    label_summaries: ?[]const LabelSummary = null,

    /// An opaque pagination token indicating where to continue the listing of
    /// datasets.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .label_summaries = "LabelSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLabelsInput, options: CallOptions) !ListLabelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLabelsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.ListLabels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLabelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLabelsOutput, body, allocator);
}
