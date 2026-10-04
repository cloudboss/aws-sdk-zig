const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const BillingMode = @import("billing_mode.zig").BillingMode;
const FederationStatus = @import("federation_status.zig").FederationStatus;
const PartitionKey = @import("partition_key.zig").PartitionKey;
const EventDataStoreStatus = @import("event_data_store_status.zig").EventDataStoreStatus;

pub const GetEventDataStoreInput = struct {
    /// The ARN (or ID suffix of the ARN) of the event data store about which you
    /// want
    /// information.
    event_data_store: []const u8,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
    };
};

pub const GetEventDataStoreOutput = struct {
    /// The advanced event selectors used to select events for the data store.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// The billing mode for the event data store.
    billing_mode: ?BillingMode = null,

    /// The timestamp of the event data store's creation.
    created_timestamp: ?i64 = null,

    /// The event data store Amazon Resource Number (ARN).
    event_data_store_arn: ?[]const u8 = null,

    /// If Lake query federation is enabled, provides the ARN of the federation role
    /// used to access the resources for the federated event data store.
    federation_role_arn: ?[]const u8 = null,

    /// Indicates the [Lake query
    /// federation](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-federation.html) status. The status is
    /// `ENABLED` if Lake query federation is enabled, or `DISABLED` if Lake query
    /// federation is disabled. You cannot delete an event data store if the
    /// `FederationStatus` is `ENABLED`.
    federation_status: ?FederationStatus = null,

    /// Specifies the KMS key ID that encrypts the events delivered by CloudTrail.
    /// The value is a fully specified ARN to a KMS key in the
    /// following format.
    ///
    /// `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Indicates whether the event data store includes events from all Regions, or
    /// only from
    /// the Region in which it was created.
    multi_region_enabled: ?bool = null,

    /// The name of the event data store.
    name: ?[]const u8 = null,

    /// Indicates whether an event data store is collecting logged events for an
    /// organization in
    /// Organizations.
    organization_enabled: ?bool = null,

    /// The partition keys for the event data store. To improve query performance
    /// and efficiency, CloudTrail Lake organizes
    /// event data into partitions based on values derived from partition keys.
    partition_keys: ?[]const PartitionKey = null,

    /// The retention period of the event data store, in days.
    retention_period: ?i32 = null,

    /// The status of an event data store.
    status: ?EventDataStoreStatus = null,

    /// Indicates that termination protection is enabled.
    termination_protection_enabled: ?bool = null,

    /// Shows the time that an event data store was updated, if applicable.
    /// `UpdatedTimestamp` is always either the same or newer than the time shown in
    /// `CreatedTimestamp`.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .billing_mode = "BillingMode",
        .created_timestamp = "CreatedTimestamp",
        .event_data_store_arn = "EventDataStoreArn",
        .federation_role_arn = "FederationRoleArn",
        .federation_status = "FederationStatus",
        .kms_key_id = "KmsKeyId",
        .multi_region_enabled = "MultiRegionEnabled",
        .name = "Name",
        .organization_enabled = "OrganizationEnabled",
        .partition_keys = "PartitionKeys",
        .retention_period = "RetentionPeriod",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventDataStoreInput, options: CallOptions) !GetEventDataStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventDataStoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GetEventDataStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventDataStoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEventDataStoreOutput, body, allocator);
}
