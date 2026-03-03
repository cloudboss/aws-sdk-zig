const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CollectionScheme = @import("collection_scheme.zig").CollectionScheme;
const Compression = @import("compression.zig").Compression;
const DataDestinationConfig = @import("data_destination_config.zig").DataDestinationConfig;
const DataPartition = @import("data_partition.zig").DataPartition;
const DiagnosticsMode = @import("diagnostics_mode.zig").DiagnosticsMode;
const SignalInformation = @import("signal_information.zig").SignalInformation;
const SignalFetchInformation = @import("signal_fetch_information.zig").SignalFetchInformation;
const SpoolingMode = @import("spooling_mode.zig").SpoolingMode;
const CampaignStatus = @import("campaign_status.zig").CampaignStatus;

pub const GetCampaignInput = struct {
    /// The name of the campaign to retrieve information about.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetCampaignOutput = struct {
    /// The Amazon Resource Name (ARN) of the campaign.
    arn: ?[]const u8 = null,

    /// Information about the data collection scheme associated with the campaign.
    collection_scheme: ?CollectionScheme = null,

    /// Whether to compress signals before transmitting data to Amazon Web Services
    /// IoT FleetWise. If
    /// `OFF` is specified, the signals aren't compressed. If it's not specified,
    /// `SNAPPY` is used.
    compression: ?Compression = null,

    /// The time the campaign was created in seconds since epoch (January 1, 1970 at
    /// midnight
    /// UTC time).
    creation_time: ?i64 = null,

    /// The destination where the campaign sends data. You can send data to an MQTT
    /// topic,
    /// or store it in Amazon S3 or Amazon Timestream.
    ///
    /// MQTT is the publish/subscribe messaging protocol used by Amazon Web Services
    /// IoT to communicate with
    /// your devices.
    ///
    /// Amazon S3 optimizes the cost of data storage and provides additional
    /// mechanisms to use vehicle data,
    /// such as data lakes, centralized data storage, data processing pipelines, and
    /// analytics.
    ///
    /// You can use Amazon Timestream to access and analyze time series data, and
    /// Timestream to query
    /// vehicle data so that you can identify trends and patterns.
    data_destination_configs: ?[]const DataDestinationConfig = null,

    /// A list of vehicle attributes associated with the campaign.
    data_extra_dimensions: ?[]const []const u8 = null,

    /// The data partitions associated with the signals collected from the vehicle.
    data_partitions: ?[]const DataPartition = null,

    /// The description of the campaign.
    description: ?[]const u8 = null,

    /// Option for a vehicle to send diagnostic trouble codes to Amazon Web Services
    /// IoT FleetWise.
    diagnostics_mode: ?DiagnosticsMode = null,

    /// The time the campaign expires, in seconds since epoch (January 1, 1970 at
    /// midnight
    /// UTC time). Vehicle data won't be collected after the campaign expires.
    expiry_time: ?i64 = null,

    /// The last time the campaign was modified.
    last_modification_time: ?i64 = null,

    /// The name of the campaign.
    name: ?[]const u8 = null,

    /// How long (in seconds) to collect raw data after a triggering event initiates
    /// the
    /// collection.
    post_trigger_collection_duration: ?i64 = null,

    /// A number indicating the priority of one campaign over another campaign for a
    /// certain
    /// vehicle or fleet. A campaign with the lowest value is deployed to vehicles
    /// before any
    /// other campaigns.
    priority: ?i32 = null,

    /// The ARN of a signal catalog.
    signal_catalog_arn: ?[]const u8 = null,

    /// Information about a list of signals to collect data on.
    signals_to_collect: ?[]const SignalInformation = null,

    /// Information about a list of signals to fetch data from.
    signals_to_fetch: ?[]const SignalFetchInformation = null,

    /// Whether to store collected data after a vehicle lost a connection with the
    /// cloud.
    /// After a connection is re-established, the data is automatically forwarded to
    /// Amazon Web Services IoT FleetWise.
    spooling_mode: ?SpoolingMode = null,

    /// The time, in milliseconds, to deliver a campaign after it was approved.
    start_time: ?i64 = null,

    /// The state of the campaign. The status can be one of: `CREATING`,
    /// `WAITING_FOR_APPROVAL`, `RUNNING`, and `SUSPENDED`.
    status: ?CampaignStatus = null,

    /// The ARN of the vehicle or the fleet targeted by the campaign.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .collection_scheme = "collectionScheme",
        .compression = "compression",
        .creation_time = "creationTime",
        .data_destination_configs = "dataDestinationConfigs",
        .data_extra_dimensions = "dataExtraDimensions",
        .data_partitions = "dataPartitions",
        .description = "description",
        .diagnostics_mode = "diagnosticsMode",
        .expiry_time = "expiryTime",
        .last_modification_time = "lastModificationTime",
        .name = "name",
        .post_trigger_collection_duration = "postTriggerCollectionDuration",
        .priority = "priority",
        .signal_catalog_arn = "signalCatalogArn",
        .signals_to_collect = "signalsToCollect",
        .signals_to_fetch = "signalsToFetch",
        .spooling_mode = "spoolingMode",
        .start_time = "startTime",
        .status = "status",
        .target_arn = "targetArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCampaignInput, options: Options) !GetCampaignOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotfleetwise");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetCampaignInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetCampaign");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCampaignOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCampaignOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DecoderManifestValidationException")) {
        return .{ .arena = arena, .kind = .{ .decoder_manifest_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNodeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_node_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSignalsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_signals_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
