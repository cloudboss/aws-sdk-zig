const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KxScalingGroupStatus = @import("kx_scaling_group_status.zig").KxScalingGroupStatus;

pub const GetKxScalingGroupInput = struct {
    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    /// A unique identifier for the kdb scaling group.
    scaling_group_name: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .scaling_group_name = "scalingGroupName",
    };
};

pub const GetKxScalingGroupOutput = struct {
    /// The identifier of the availability zones.
    availability_zone_id: ?[]const u8 = null,

    /// The list of Managed kdb clusters that are currently active in the given
    /// scaling group.
    clusters: ?[]const []const u8 = null,

    /// The timestamp at which the scaling group was created in FinSpace. The value
    /// is determined as epoch time in milliseconds. For example, the value for
    /// Monday, November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// The memory and CPU capabilities of the scaling group host on which FinSpace
    /// Managed kdb clusters will be placed.
    ///
    /// It can have one of the following values:
    ///
    /// * `kx.sg.large` – The host type with a configuration of 16 GiB
    /// memory and 2 vCPUs.
    ///
    /// * `kx.sg.xlarge` – The host type with a configuration of 32 GiB
    /// memory and 4 vCPUs.
    ///
    /// * `kx.sg.2xlarge` – The host type with a configuration of 64 GiB
    /// memory and 8 vCPUs.
    ///
    /// * `kx.sg.4xlarge` – The host type with a configuration of 108 GiB memory and
    ///   16 vCPUs.
    ///
    /// * `kx.sg.8xlarge` – The host type with a configuration of 216 GiB memory and
    ///   32 vCPUs.
    ///
    /// * `kx.sg.16xlarge` – The host type with a configuration of 432 GiB memory
    ///   and 64 vCPUs.
    ///
    /// * `kx.sg.32xlarge` – The host type with a configuration of 864 GiB memory
    ///   and 128 vCPUs.
    ///
    /// * `kx.sg1.16xlarge` – The host type with a configuration of 1949 GiB memory
    ///   and 64 vCPUs.
    ///
    /// * `kx.sg1.24xlarge` – The host type with a configuration of 2948 GiB memory
    ///   and 96 vCPUs.
    host_type: ?[]const u8 = null,

    /// The last time that the scaling group was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// The ARN identifier for the scaling group.
    scaling_group_arn: ?[]const u8 = null,

    /// A unique identifier for the kdb scaling group.
    scaling_group_name: ?[]const u8 = null,

    /// The status of scaling group.
    ///
    /// * CREATING – The scaling group creation is in progress.
    ///
    /// * CREATE_FAILED – The scaling group creation has failed.
    ///
    /// * ACTIVE – The scaling group is active.
    ///
    /// * UPDATING – The scaling group is in the process of being updated.
    ///
    /// * UPDATE_FAILED – The update action failed.
    ///
    /// * DELETING – The scaling group is in the process of being deleted.
    ///
    /// * DELETE_FAILED – The system failed to delete the scaling group.
    ///
    /// * DELETED – The scaling group is successfully deleted.
    status: ?KxScalingGroupStatus = null,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .clusters = "clusters",
        .created_timestamp = "createdTimestamp",
        .host_type = "hostType",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .scaling_group_arn = "scalingGroupArn",
        .scaling_group_name = "scalingGroupName",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKxScalingGroupInput, options: CallOptions) !GetKxScalingGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKxScalingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/scalingGroups/");
    try path_buf.appendSlice(allocator, input.scaling_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKxScalingGroupOutput {
    var result: GetKxScalingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetKxScalingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
