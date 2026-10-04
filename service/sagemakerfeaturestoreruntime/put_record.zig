const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureValue = @import("feature_value.zig").FeatureValue;
const TargetStore = @import("target_store.zig").TargetStore;
const TtlDuration = @import("ttl_duration.zig").TtlDuration;

pub const PutRecordInput = struct {
    /// The name or Amazon Resource Name (ARN) of the feature group that you want to
    /// insert the
    /// record into.
    feature_group_name: []const u8,

    /// List of FeatureValues to be inserted. This will be a full over-write. If you
    /// only want
    /// to update few of the feature values, do the following:
    ///
    /// * Use `GetRecord` to retrieve the latest record.
    ///
    /// * Update the record returned from `GetRecord`.
    ///
    /// * Use `PutRecord` to update feature values.
    record: []const FeatureValue,

    /// A list of stores to which you're adding the record. By default, Feature
    /// Store adds the
    /// record to all of the stores that you're using for the `FeatureGroup`.
    target_stores: ?[]const TargetStore = null,

    /// Time to live duration, where the record is hard deleted after the expiration
    /// time is
    /// reached; `ExpiresAt` = `EventTime` + `TtlDuration`. For
    /// information on HardDelete, see the
    /// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) API in the Amazon SageMaker API Reference guide.
    ttl_duration: ?TtlDuration = null,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .record = "Record",
        .target_stores = "TargetStores",
        .ttl_duration = "TtlDuration",
    };
};

pub const PutRecordOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRecordInput, options: CallOptions) !PutRecordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("featurestore-runtime.sagemaker", "SageMaker FeatureStore Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/FeatureGroup/");
    try path_buf.appendSlice(allocator, input.feature_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Record\":");
    try aws.json.writeValue(@TypeOf(input.record), input.record, allocator, &body_buf);
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRecordOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutRecordOutput = .{};

    return result;
}
