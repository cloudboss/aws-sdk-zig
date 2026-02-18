const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceInterruptionBehavior = @import("instance_interruption_behavior.zig").InstanceInterruptionBehavior;
const RequestSpotLaunchSpecification = @import("request_spot_launch_specification.zig").RequestSpotLaunchSpecification;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SpotInstanceType = @import("spot_instance_type.zig").SpotInstanceType;
const SpotInstanceRequest = @import("spot_instance_request.zig").SpotInstanceRequest;
const serde = @import("serde.zig");

pub const RequestSpotInstancesInput = struct {
    /// The user-specified name for a logical grouping of requests.
    ///
    /// When you specify an Availability Zone group in a Spot Instance request, all
    /// Spot
    /// Instances in the request are launched in the same Availability Zone.
    /// Instance proximity
    /// is maintained with this parameter, but the choice of Availability Zone is
    /// not. The group
    /// applies only to requests for Spot Instances of the same instance type. Any
    /// additional
    /// Spot Instance requests that are specified with the same Availability Zone
    /// group name are
    /// launched in that same Availability Zone, as long as at least one instance
    /// from the group
    /// is still active.
    ///
    /// If there is no active instance running in the Availability Zone group that
    /// you specify
    /// for a new Spot Instance request (all instances are terminated, the request
    /// is expired,
    /// or the maximum price you specified falls below current Spot price), then
    /// Amazon EC2 launches
    /// the instance in any Availability Zone where the constraint can be met.
    /// Consequently, the
    /// subsequent set of Spot Instances could be placed in a different zone from
    /// the original
    /// request, even if you specified the same Availability Zone group.
    ///
    /// Default: Instances are launched in any available Availability Zone.
    availability_zone_group: ?[]const u8 = null,

    /// Deprecated.
    block_duration_minutes: ?i32 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [Ensuring idempotency in
    /// Amazon EC2 API
    /// requests](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html) in the *Amazon EC2 User Guide*.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The maximum number of Spot Instances to launch.
    ///
    /// Default: 1
    instance_count: ?i32 = null,

    /// The behavior when a Spot Instance is interrupted. The default is
    /// `terminate`.
    instance_interruption_behavior: ?InstanceInterruptionBehavior = null,

    /// The instance launch group. Launch groups are Spot Instances that launch
    /// together and
    /// terminate together.
    ///
    /// Default: Instances are launched and terminated individually
    launch_group: ?[]const u8 = null,

    /// The launch specification.
    launch_specification: ?RequestSpotLaunchSpecification = null,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend
    /// using this parameter because it can lead to increased interruptions. If you
    /// do not specify this parameter, you will pay the current Spot price.
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8 = null,

    /// The key-value pair for tagging the Spot Instance request on creation. The
    /// value for
    /// `ResourceType` must be `spot-instances-request`, otherwise the
    /// Spot Instance request fails. To tag the Spot Instance request after it has
    /// been created,
    /// see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    tag_specifications: ?[]const TagSpecification = null,

    /// The Spot Instance request type.
    ///
    /// Default: `one-time`
    @"type": ?SpotInstanceType = null,

    /// The start date of the request. If this is a one-time request, the request
    /// becomes
    /// active at this date and time and remains active until all instances launch,
    /// the request
    /// expires, or the request is canceled. If the request is persistent, the
    /// request becomes
    /// active at this date and time and remains active until it expires or is
    /// canceled.
    ///
    /// The specified start date and time cannot be equal to the current date and
    /// time. You
    /// must specify a start date and time that occurs after the current date and
    /// time.
    valid_from: ?i64 = null,

    /// The end date of the request, in UTC format
    /// (*YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    ///
    /// * For a persistent request, the request remains active until the
    /// `ValidUntil` date and time is reached. Otherwise, the request
    /// remains active until you cancel it.
    ///
    /// * For a one-time request, the request remains active until all instances
    ///   launch,
    /// the request is canceled, or the `ValidUntil` date and time is
    /// reached. By default, the request is valid for 7 days from the date the
    /// request
    /// was created.
    valid_until: ?i64 = null,
};

pub const RequestSpotInstancesOutput = struct {
    /// The Spot Instance requests.
    spot_instance_requests: ?[]const SpotInstanceRequest = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RequestSpotInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RequestSpotInstancesInput, options: Options) !RequestSpotInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: RequestSpotInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RequestSpotInstances&Version=2016-11-15");
    if (input.availability_zone_group) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneGroup=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.block_duration_minutes) |v| {
        try body_buf.appendSlice(alloc, "&BlockDurationMinutes=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_count) |v| {
        try body_buf.appendSlice(alloc, "&InstanceCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.instance_interruption_behavior) |v| {
        try body_buf.appendSlice(alloc, "&InstanceInterruptionBehavior=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.launch_group) |v| {
        try body_buf.appendSlice(alloc, "&LaunchGroup=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.launch_specification) |v| {
        if (v.addressing_type) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.AddressingType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.block_device_mappings) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.DeviceName=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.device_name) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                if (item.ebs) |sv_1| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.AvailabilityZone=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.availability_zone) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.AvailabilityZoneId=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.availability_zone_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.delete_on_termination) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.EbsCardIndex=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.ebs_card_index) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.Encrypted=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.encrypted) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.Iops=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.iops) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.KmsKeyId=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.kms_key_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.OutpostArn=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.outpost_arn) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.SnapshotId=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.snapshot_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.Throughput=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.throughput) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.VolumeInitializationRate=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.volume_initialization_rate) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.VolumeSize=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.volume_size) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.Ebs.VolumeType=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.volume_type) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.NoDevice=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.no_device) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.BlockDeviceMappings.item.{d}.VirtualName=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.virtual_name) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
            }
        }
        if (v.ebs_optimized) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.EbsOptimized=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.iam_instance_profile) |sv| {
            if (sv.arn) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.IamInstanceProfile.Arn=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.name) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.IamInstanceProfile.Name=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
        }
        if (v.image_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.ImageId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.instance_type) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.InstanceType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.kernel_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.KernelId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.key_name) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.KeyName=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.monitoring) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.Monitoring.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv.enabled) "true" else "false");
        }
        if (v.network_interfaces) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.AssociateCarrierIpAddress=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.associate_carrier_ip_address) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.AssociatePublicIpAddress=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.associate_public_ip_address) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                    }
                }
                if (item.connection_tracking_specification) |sv_1| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.ConnectionTrackingSpecification.TcpEstablishedTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.tcp_established_timeout) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.ConnectionTrackingSpecification.UdpStreamTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.udp_stream_timeout) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.ConnectionTrackingSpecification.UdpTimeout=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.udp_timeout) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.delete_on_termination) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Description=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.description) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.DeviceIndex=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.device_index) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.EnaQueueCount=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.ena_queue_count) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                if (item.ena_srd_specification) |sv_1| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.EnaSrdSpecification.EnaSrdEnabled=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_1.ena_srd_enabled) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    if (sv_1.ena_srd_udp_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=", .{n}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.ena_srd_udp_enabled) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                    }
                }
                if (item.groups) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Groups.SecurityGroupId.{d}=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.InterfaceType=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.interface_type) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv4PrefixCount=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.ipv_4_prefix_count) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                if (item.ipv_4_prefixes) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv4Prefixes.item.{d}.Ipv4Prefix=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item_1.ipv_4_prefix) |fv_2| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv6AddressCount=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.ipv_6_address_count) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                if (item.ipv_6_addresses) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv6Addresses.item.{d}.Ipv6Address=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item_1.ipv_6_address) |fv_2| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv6Addresses.item.{d}.IsPrimaryIpv6=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item_1.is_primary_ipv_6) |fv_2| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv6PrefixCount=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.ipv_6_prefix_count) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                if (item.ipv_6_prefixes) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.Ipv6Prefixes.item.{d}.Ipv6Prefix=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item_1.ipv_6_prefix) |fv_2| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.NetworkCardIndex=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.network_card_index) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.NetworkInterfaceId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.network_interface_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.PrimaryIpv6=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.primary_ipv_6) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.PrivateIpAddress=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.private_ip_address) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
                if (item.private_ip_addresses) |lst_1| {
                    for (lst_1, 0..) |item_1, idx_1| {
                        const n_1 = idx_1 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.PrivateIpAddresses.item.{d}.Primary=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item_1.primary) |fv_2| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.PrivateIpAddresses.item.{d}.PrivateIpAddress=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item_1.private_ip_address) |fv_2| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.SecondaryPrivateIpAddressCount=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.secondary_private_ip_address_count) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.NetworkInterfaces.item.{d}.SubnetId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.subnet_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
            }
        }
        if (v.placement) |sv| {
            if (sv.availability_zone) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.AvailabilityZone=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.availability_zone_id) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.AvailabilityZoneId=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.group_name) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.GroupName=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.tenancy) |sv2| {
                try body_buf.appendSlice(alloc, "&LaunchSpecification.Placement.Tenancy=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
            }
        }
        if (v.ramdisk_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.RamdiskId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.security_group_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.SecurityGroupIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.security_groups) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchSpecification.SecurityGroups.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.subnet_id) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.SubnetId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.user_data) |sv| {
            try body_buf.appendSlice(alloc, "&LaunchSpecification.UserData=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.spot_price) |v| {
        try body_buf.appendSlice(alloc, "&SpotPrice=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(alloc, "&Type=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.valid_from) |v| {
        try body_buf.appendSlice(alloc, "&ValidFrom=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.valid_until) |v| {
        try body_buf.appendSlice(alloc, "&ValidUntil=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RequestSpotInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RequestSpotInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "spotInstanceRequestSet")) {
                    result.spot_instance_requests = try serde.deserializeSpotInstanceRequestList(&reader, alloc, "item");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
