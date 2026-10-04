const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxNAS1Configuration = @import("kx_nas1_configuration.zig").KxNAS1Configuration;
const KxVolumeType = @import("kx_volume_type.zig").KxVolumeType;
const KxVolumeStatus = @import("kx_volume_status.zig").KxVolumeStatus;

pub const CreateKxVolumeInput = struct {
    /// The identifier of the availability zones.
    availability_zone_ids: []const []const u8,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: KxAzMode,

    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// A description of the volume.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment, whose clusters can attach to
    /// the volume.
    environment_id: []const u8,

    /// Specifies the configuration for the Network attached storage (NAS_1) file
    /// system volume. This
    /// parameter is required when you choose `volumeType` as
    /// *NAS_1*.
    nas_1_configuration: ?KxNAS1Configuration = null,

    /// A list of key-value pairs to label the volume. You can add up to 50 tags to
    /// a volume.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the volume.
    volume_name: []const u8,

    /// The type of file system volume. Currently, FinSpace only supports `NAS_1`
    /// volume type. When you select `NAS_1` volume type, you must also provide
    /// `nas1Configuration`.
    volume_type: KxVolumeType,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .az_mode = "azMode",
        .client_token = "clientToken",
        .description = "description",
        .environment_id = "environmentId",
        .nas_1_configuration = "nas1Configuration",
        .tags = "tags",
        .volume_name = "volumeName",
        .volume_type = "volumeType",
    };
};

pub const CreateKxVolumeOutput = struct {
    /// The identifier of the availability zones.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: ?KxAzMode = null,

    /// The timestamp at which the volume was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// A description of the volume.
    description: ?[]const u8 = null,

    /// A unique identifier for the kdb environment, whose clusters can attach to
    /// the volume.
    environment_id: ?[]const u8 = null,

    /// Specifies the configuration for the Network attached storage (NAS_1) file
    /// system volume.
    nas_1_configuration: ?KxNAS1Configuration = null,

    /// The status of volume creation.
    ///
    /// * CREATING – The volume creation is in progress.
    ///
    /// * CREATE_FAILED – The volume creation has failed.
    ///
    /// * ACTIVE – The volume is active.
    ///
    /// * UPDATING – The volume is in the process of being updated.
    ///
    /// * UPDATE_FAILED – The update action failed.
    ///
    /// * UPDATED – The volume is successfully updated.
    ///
    /// * DELETING – The volume is in the process of being deleted.
    ///
    /// * DELETE_FAILED – The system failed to delete the volume.
    ///
    /// * DELETED – The volume is successfully deleted.
    status: ?KxVolumeStatus = null,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8 = null,

    /// The ARN identifier of the volume.
    volume_arn: ?[]const u8 = null,

    /// A unique identifier for the volume.
    volume_name: ?[]const u8 = null,

    /// The type of file system volume. Currently, FinSpace only supports `NAS_1`
    /// volume type.
    volume_type: ?KxVolumeType = null,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .az_mode = "azMode",
        .created_timestamp = "createdTimestamp",
        .description = "description",
        .environment_id = "environmentId",
        .nas_1_configuration = "nas1Configuration",
        .status = "status",
        .status_reason = "statusReason",
        .volume_arn = "volumeArn",
        .volume_name = "volumeName",
        .volume_type = "volumeType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKxVolumeInput, options: CallOptions) !CreateKxVolumeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKxVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/kxvolumes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"availabilityZoneIds\":");
    try aws.json.writeValue(@TypeOf(input.availability_zone_ids), input.availability_zone_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"azMode\":");
    try aws.json.writeValue(@TypeOf(input.az_mode), input.az_mode, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.nas_1_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nas1Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"volumeName\":");
    try aws.json.writeValue(@TypeOf(input.volume_name), input.volume_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"volumeType\":");
    try aws.json.writeValue(@TypeOf(input.volume_type), input.volume_type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKxVolumeOutput {
    const result: CreateKxVolumeOutput = try aws.json.parseJsonObject(
        CreateKxVolumeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
