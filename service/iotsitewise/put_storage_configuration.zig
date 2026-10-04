const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisassociatedDataStorageState = @import("disassociated_data_storage_state.zig").DisassociatedDataStorageState;
const MultiLayerStorage = @import("multi_layer_storage.zig").MultiLayerStorage;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const StorageType = @import("storage_type.zig").StorageType;
const WarmTierState = @import("warm_tier_state.zig").WarmTierState;
const WarmTierRetentionPeriod = @import("warm_tier_retention_period.zig").WarmTierRetentionPeriod;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

pub const PutStorageConfigurationInput = struct {
    /// Describes the configuration for ingesting NULL and NaN data. By default the
    /// feature is
    /// allowed. The feature is disallowed if the value is `true`.
    disallow_ingest_null_na_n: ?bool = null,

    /// Contains the storage configuration for time series (data streams) that
    /// aren't associated with asset properties.
    /// The `disassociatedDataStorage` can be one of the following values:
    ///
    /// * `ENABLED` – IoT SiteWise accepts time series that aren't associated with
    ///   asset properties.
    ///
    /// After the `disassociatedDataStorage` is enabled, you can't disable it.
    ///
    /// * `DISABLED` – IoT SiteWise doesn't accept time series (data streams) that
    ///   aren't associated with asset properties.
    ///
    /// For more information, see [Data
    /// streams](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/data-streams.html)
    /// in the *IoT SiteWise User Guide*.
    disassociated_data_storage: ?DisassociatedDataStorageState = null,

    /// Identifies a storage destination. If you specified `MULTI_LAYER_STORAGE` for
    /// the storage type,
    /// you must specify a `MultiLayerStorage` object.
    multi_layer_storage: ?MultiLayerStorage = null,

    retention_period: ?RetentionPeriod = null,

    /// The storage tier that you specified for your data.
    /// The `storageType` parameter can be one of the following values:
    ///
    /// * `SITEWISE_DEFAULT_STORAGE` – IoT SiteWise saves your data into the hot
    ///   tier.
    /// The hot tier is a service-managed database.
    ///
    /// * `MULTI_LAYER_STORAGE` – IoT SiteWise saves your data in both the cold tier
    ///   and the hot tier.
    /// The cold tier is a customer-managed Amazon S3 bucket.
    storage_type: StorageType,

    /// A service managed storage tier optimized for analytical queries. It stores
    /// periodically uploaded, buffered and historical data ingested with the
    /// CreaeBulkImportJob API.
    warm_tier: ?WarmTierState = null,

    /// Set this period to specify how long your data is stored in the warm tier
    /// before it is deleted. You can set this only if cold tier is enabled.
    warm_tier_retention_period: ?WarmTierRetentionPeriod = null,

    pub const json_field_names = .{
        .disallow_ingest_null_na_n = "disallowIngestNullNaN",
        .disassociated_data_storage = "disassociatedDataStorage",
        .multi_layer_storage = "multiLayerStorage",
        .retention_period = "retentionPeriod",
        .storage_type = "storageType",
        .warm_tier = "warmTier",
        .warm_tier_retention_period = "warmTierRetentionPeriod",
    };
};

pub const PutStorageConfigurationOutput = struct {
    configuration_status: ?ConfigurationStatus = null,

    /// Describes the configuration for ingesting NULL and NaN data. By default the
    /// feature is
    /// allowed. The feature is disallowed if the value is `true`.
    disallow_ingest_null_na_n: ?bool = null,

    /// Contains the storage configuration for time series (data streams) that
    /// aren't associated with asset properties.
    /// The `disassociatedDataStorage` can be one of the following values:
    ///
    /// * `ENABLED` – IoT SiteWise accepts time series that aren't associated with
    ///   asset properties.
    ///
    /// After the `disassociatedDataStorage` is enabled, you can't disable it.
    ///
    /// * `DISABLED` – IoT SiteWise doesn't accept time series (data streams) that
    ///   aren't associated with asset properties.
    ///
    /// For more information, see [Data
    /// streams](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/data-streams.html)
    /// in the *IoT SiteWise User Guide*.
    disassociated_data_storage: ?DisassociatedDataStorageState = null,

    /// Contains information about the storage destination.
    multi_layer_storage: ?MultiLayerStorage = null,

    retention_period: ?RetentionPeriod = null,

    /// The storage tier that you specified for your data.
    /// The `storageType` parameter can be one of the following values:
    ///
    /// * `SITEWISE_DEFAULT_STORAGE` – IoT SiteWise saves your data into the hot
    ///   tier.
    /// The hot tier is a service-managed database.
    ///
    /// * `MULTI_LAYER_STORAGE` – IoT SiteWise saves your data in both the cold tier
    ///   and the hot tier.
    /// The cold tier is a customer-managed Amazon S3 bucket.
    storage_type: StorageType,

    /// A service managed storage tier optimized for analytical queries. It stores
    /// periodically uploaded, buffered and historical data ingested with the
    /// CreaeBulkImportJob API.
    warm_tier: ?WarmTierState = null,

    /// Set this period to specify how long your data is stored in the warm tier
    /// before it is deleted. You can set this only if cold tier is enabled.
    warm_tier_retention_period: ?WarmTierRetentionPeriod = null,

    pub const json_field_names = .{
        .configuration_status = "configurationStatus",
        .disallow_ingest_null_na_n = "disallowIngestNullNaN",
        .disassociated_data_storage = "disassociatedDataStorage",
        .multi_layer_storage = "multiLayerStorage",
        .retention_period = "retentionPeriod",
        .storage_type = "storageType",
        .warm_tier = "warmTier",
        .warm_tier_retention_period = "warmTierRetentionPeriod",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutStorageConfigurationInput, options: CallOptions) !PutStorageConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutStorageConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configuration/account/storage";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.disallow_ingest_null_na_n) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"disallowIngestNullNaN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.disassociated_data_storage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"disassociatedDataStorage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multi_layer_storage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multiLayerStorage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retention_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retentionPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"storageType\":");
    try aws.json.writeValue(@TypeOf(input.storage_type), input.storage_type, allocator, &body_buf);
    has_prev = true;
    if (input.warm_tier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"warmTier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.warm_tier_retention_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"warmTierRetentionPeriod\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutStorageConfigurationOutput {
    const result: PutStorageConfigurationOutput = try aws.json.parseJsonObject(
        PutStorageConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
