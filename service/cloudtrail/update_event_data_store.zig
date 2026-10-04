const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const BillingMode = @import("billing_mode.zig").BillingMode;
const FederationStatus = @import("federation_status.zig").FederationStatus;
const EventDataStoreStatus = @import("event_data_store_status.zig").EventDataStoreStatus;

pub const UpdateEventDataStoreInput = struct {
    /// The advanced event selectors used to select events for the event data store.
    /// You can
    /// configure up to five advanced event selectors for each event data store.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// You can't change the billing mode from `EXTENDABLE_RETENTION_PRICING` to
    /// `FIXED_RETENTION_PRICING`. If `BillingMode` is set to
    /// `EXTENDABLE_RETENTION_PRICING` and you want to use `FIXED_RETENTION_PRICING`
    /// instead, you'll need to stop ingestion on the event data store and create a
    /// new event data store that uses `FIXED_RETENTION_PRICING`.
    ///
    /// The billing mode for the event data store determines the cost
    /// for ingesting events and the default and maximum retention period for the
    /// event data store.
    ///
    /// The following are the possible values:
    ///
    /// * `EXTENDABLE_RETENTION_PRICING` - This billing mode is generally
    ///   recommended if you want a flexible retention period of up to 3653 days
    ///   (about 10 years). The default retention period for this billing mode is
    /// 366 days.
    ///
    /// * `FIXED_RETENTION_PRICING` - This billing mode is recommended if you expect
    ///   to ingest more than 25 TB of event data per month and need a retention
    ///   period of up to 2557 days (about 7 years).
    /// The default retention period for this billing mode is 2557 days.
    ///
    /// For more information about CloudTrail pricing,
    /// see [CloudTrail Pricing](http://aws.amazon.com/cloudtrail/pricing/) and
    /// [Managing CloudTrail Lake
    /// costs](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-lake-manage-costs.html).
    billing_mode: ?BillingMode = null,

    /// The ARN (or the ID suffix of the ARN) of the event data store that you want
    /// to
    /// update.
    event_data_store: []const u8,

    /// Specifies the KMS key ID to use to encrypt the events delivered by
    /// CloudTrail. The value can be an alias name prefixed by `alias/`, a
    /// fully specified ARN to an alias, a fully specified ARN to a key, or a
    /// globally unique
    /// identifier.
    ///
    /// Disabling or deleting the KMS key, or removing CloudTrail
    /// permissions on the key, prevents CloudTrail from logging events to the event
    /// data
    /// store, and prevents users from querying the data in the event data store
    /// that was
    /// encrypted with the key. After you associate an event data store with a KMS
    /// key, the KMS key cannot be removed or changed. Before you
    /// disable or delete a KMS key that you are using with an event data store,
    /// delete or back up your event data store.
    ///
    /// CloudTrail also supports KMS multi-Region keys. For more
    /// information about multi-Region keys, see [Using multi-Region
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) in the *Key Management Service Developer Guide*.
    ///
    /// Examples:
    ///
    /// * `alias/MyAliasName`
    ///
    /// * `arn:aws:kms:us-east-2:123456789012:alias/MyAliasName`
    ///
    /// *
    ///   `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    ///
    /// * `12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether an event data store collects events from all Regions, or
    /// only from the
    /// Region in which it was created.
    multi_region_enabled: ?bool = null,

    /// The event data store name.
    name: ?[]const u8 = null,

    /// Specifies whether an event data store collects events logged for an
    /// organization in
    /// Organizations.
    ///
    /// Only the management account for the organization can convert an organization
    /// event data store to a non-organization event data store, or convert a
    /// non-organization event data store to
    /// an organization event data store.
    organization_enabled: ?bool = null,

    /// The retention period of the event data store, in days. If `BillingMode` is
    /// set to `EXTENDABLE_RETENTION_PRICING`, you can set a retention period of
    /// up to 3653 days, the equivalent of 10 years. If `BillingMode` is set to
    /// `FIXED_RETENTION_PRICING`, you can set a retention period of
    /// up to 2557 days, the equivalent of seven years.
    ///
    /// CloudTrail Lake determines whether to retain an event by checking if the
    /// `eventTime`
    /// of the event is within the specified retention period. For example, if you
    /// set a retention period of 90 days, CloudTrail will remove events
    /// when the `eventTime` is older than 90 days.
    ///
    /// If you decrease the retention period of an event data store, CloudTrail will
    /// remove any events with an `eventTime` older than the new retention period.
    /// For example, if the previous
    /// retention period was 365 days and you decrease it to 100 days, CloudTrail
    /// will remove events with an `eventTime` older than 100 days.
    retention_period: ?i32 = null,

    /// Indicates that termination protection is enabled and the event data store
    /// cannot be
    /// automatically deleted.
    termination_protection_enabled: ?bool = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .billing_mode = "BillingMode",
        .event_data_store = "EventDataStore",
        .kms_key_id = "KmsKeyId",
        .multi_region_enabled = "MultiRegionEnabled",
        .name = "Name",
        .organization_enabled = "OrganizationEnabled",
        .retention_period = "RetentionPeriod",
        .termination_protection_enabled = "TerminationProtectionEnabled",
    };
};

pub const UpdateEventDataStoreOutput = struct {
    /// The advanced event selectors that are applied to the event data store.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// The billing mode for the event data store.
    billing_mode: ?BillingMode = null,

    /// The timestamp that shows when an event data store was first created.
    created_timestamp: ?i64 = null,

    /// The ARN of the event data store.
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

    /// The retention period, in days.
    retention_period: ?i32 = null,

    /// The status of an event data store.
    status: ?EventDataStoreStatus = null,

    /// Indicates whether termination protection is enabled for the event data
    /// store.
    termination_protection_enabled: ?bool = null,

    /// The timestamp that shows when the event data store was last updated.
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
        .retention_period = "RetentionPeriod",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventDataStoreInput, options: CallOptions) !UpdateEventDataStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventDataStoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.UpdateEventDataStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventDataStoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEventDataStoreOutput, body, allocator);
}
