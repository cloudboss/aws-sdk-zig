const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const BillingMode = @import("billing_mode.zig").BillingMode;
const EventDataStoreStatus = @import("event_data_store_status.zig").EventDataStoreStatus;

pub const RestoreEventDataStoreInput = struct {
    /// The ARN (or the ID suffix of the ARN) of the event data store that you want
    /// to
    /// restore.
    event_data_store: []const u8,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
    };
};

pub const RestoreEventDataStoreOutput = struct {
    /// The advanced event selectors that were used to select events.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// The billing mode for the event data store.
    billing_mode: ?BillingMode = null,

    /// The timestamp of an event data store's creation.
    created_timestamp: ?i64 = null,

    /// The event data store ARN.
    event_data_store_arn: ?[]const u8 = null,

    /// Specifies the KMS key ID that encrypts the events delivered by CloudTrail.
    /// The value is a fully specified ARN to a KMS key in the
    /// following format.
    ///
    /// `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Indicates whether the event data store is collecting events from all
    /// Regions, or only
    /// from the Region in which the event data store was created.
    multi_region_enabled: ?bool = null,

    /// The name of the event data store.
    name: ?[]const u8 = null,

    /// Indicates whether an event data store is collecting logged events for an
    /// organization in
    /// Organizations.
    organization_enabled: ?bool = null,

    /// The retention period, in days.
    retention_period: ?i32 = null,

    /// The status of the event data store.
    status: ?EventDataStoreStatus = null,

    /// Indicates that termination protection is enabled and the event data store
    /// cannot be
    /// automatically deleted.
    termination_protection_enabled: ?bool = null,

    /// The timestamp that shows when an event data store was updated, if
    /// applicable.
    /// `UpdatedTimestamp` is always either the same or newer than the time shown in
    /// `CreatedTimestamp`.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .billing_mode = "BillingMode",
        .created_timestamp = "CreatedTimestamp",
        .event_data_store_arn = "EventDataStoreArn",
        .kms_key_id = "KmsKeyId",
        .multi_region_enabled = "MultiRegionEnabled",
        .name = "Name",
        .organization_enabled = "OrganizationEnabled",
        .retention_period = "RetentionPeriod",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreEventDataStoreInput, options: CallOptions) !RestoreEventDataStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreEventDataStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.RestoreEventDataStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreEventDataStoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreEventDataStoreOutput, body, allocator);
}
