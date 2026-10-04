const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureValue = @import("feature_value.zig").FeatureValue;
const TargetStore = @import("target_store.zig").TargetStore;
const TtlDuration = @import("ttl_duration.zig").TtlDuration;

pub const UpdateRecordInput = struct {
    /// The identifier for the feature group that contains the record to update. You
    /// can
    /// specify one of the following:
    ///
    /// * The feature group name.
    ///
    /// * The feature group Amazon Resource Name (ARN).
    feature_group_name: []const u8,

    /// The feature values to write to the record.
    features: []const FeatureValue,

    /// The value that uniquely identifies the record in the feature group. This
    /// must
    /// match the value defined by the feature group's record identifier feature.
    record_identifier_value_as_string: []const u8,

    /// The target stores for the record update. By default, Amazon SageMaker
    /// Feature
    /// Store updates the record in all stores associated with the
    /// `FeatureGroup`.
    target_stores: ?[]const TargetStore = null,

    /// The time-to-live (TTL) duration for the record. Amazon SageMaker Feature
    /// Store
    /// deletes the record when `EventTime` + `TtlDuration`
    /// elapses. If you omit this parameter, the record's existing TTL setting
    /// remains
    /// unchanged. For information about `HardDelete`, see the
    /// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) operation in the Amazon SageMaker API Reference.
    ttl_duration: ?TtlDuration = null,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .features = "Features",
        .record_identifier_value_as_string = "RecordIdentifierValueAsString",
        .target_stores = "TargetStores",
        .ttl_duration = "TtlDuration",
    };
};

pub const UpdateRecordOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRecordInput, options: CallOptions) !UpdateRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("featurestore-runtime.sagemaker", "SageMaker FeatureStore Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/FeatureGroup/");
    try path_buf.appendSlice(allocator, input.feature_group_name);
    try path_buf.appendSlice(allocator, "/Record");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Features\":");
    try aws.json.writeValue(@TypeOf(input.features), input.features, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecordIdentifierValueAsString\":");
    try aws.json.writeValue(@TypeOf(input.record_identifier_value_as_string), input.record_identifier_value_as_string, allocator, &body_buf);
    has_prev = true;
    if (input.target_stores) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetStores\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ttl_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TtlDuration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRecordOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateRecordOutput = .{};

    return result;
}
