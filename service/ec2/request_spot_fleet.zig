const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SpotFleetRequestConfigData = @import("spot_fleet_request_config_data.zig").SpotFleetRequestConfigData;
const serde = @import("serde.zig");

pub const RequestSpotFleetInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The configuration for the Spot Fleet request.
    spot_fleet_request_config: SpotFleetRequestConfigData,
};

pub const RequestSpotFleetOutput = struct {
    /// The ID of the Spot Fleet request.
    spot_fleet_request_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestSpotFleetInput, options: CallOptions) !RequestSpotFleetOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RequestSpotFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=RequestSpotFleet&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.spot_fleet_request_config.allocation_strategy) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.AllocationStrategy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.spot_fleet_request_config.client_token) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.context) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.Context=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.excess_capacity_termination_policy) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.ExcessCapacityTerminationPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.spot_fleet_request_config.fulfilled_capacity) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.FulfilledCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.IamFleetRole=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.spot_fleet_request_config.iam_fleet_role);
    if (input.spot_fleet_request_config.instance_interruption_behavior) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.InstanceInterruptionBehavior=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.spot_fleet_request_config.instance_pools_to_use_count) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.InstancePoolsToUseCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.launch_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.addressing_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.AddressingType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.block_device_mappings) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.device_name) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.DeviceName=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item_1.ebs) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.availability_zone) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.AvailabilityZone=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.availability_zone_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.AvailabilityZoneId=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.delete_on_termination) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.ebs_card_index) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.EbsCardIndex=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.encrypted) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.iops) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.Iops=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.kms_key_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.KmsKeyId=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.outpost_arn) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.OutpostArn=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.snapshot_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.throughput) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.Throughput=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.volume_initialization_rate) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.VolumeInitializationRate=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.volume_size) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.volume_type) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.no_device) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.NoDevice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.virtual_name) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.BlockDeviceMapping.{d}.VirtualName=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.ebs_optimized) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.EbsOptimized=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
            }
            if (item.iam_instance_profile) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.arn) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.IamInstanceProfile.Arn=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.IamInstanceProfile.Name=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.image_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.ImageId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.instance_requirements) |sv_1| {
                if (sv_1.accelerator_count) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.accelerator_manufacturers) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorManufacturerSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.wireName());
                        }
                    }
                }
                if (sv_1.accelerator_names) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorNameSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.wireName());
                        }
                    }
                }
                if (sv_1.accelerator_total_memory_mi_b) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.accelerator_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AcceleratorTypeSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.wireName());
                        }
                    }
                }
                if (sv_1.allowed_instance_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.AllowedInstanceTypeSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.bare_metal) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.BareMetal=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                if (sv_1.baseline_ebs_bandwidth_mbps) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.baseline_performance_factors) |sv_2| {
                    if (sv_2.cpu) |sv_3| {
                        if (sv_3.references) |lst_4| {
                            for (lst_4, 0..) |item_4, idx_4| {
                                const n_4 = idx_4 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (item_4.instance_family) |fv_5| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.ReferenceSet.{d}.InstanceFamily=", .{n, n_4}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_5);
                                    }
                                }
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.burstable_performance) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.BurstablePerformance=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                if (sv_1.cpu_manufacturers) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.CpuManufacturerSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.wireName());
                        }
                    }
                }
                if (sv_1.excluded_instance_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.ExcludedInstanceTypeSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.instance_generations) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.InstanceGenerationSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.wireName());
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.local_storage) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.LocalStorage=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
                if (sv_1.local_storage_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.LocalStorageTypeSet.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, item_2.wireName());
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                if (sv_1.memory_gi_b_per_v_cpu) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.memory_mi_b) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.MemoryMiB.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.MemoryMiB.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.network_bandwidth_gbps) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.network_interface_count) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.on_demand_max_price_percentage_over_lowest_price) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.require_encryption_in_transit) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.RequireEncryptionInTransit=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.require_hibernate_support) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.RequireHibernateSupport=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.spot_max_price_percentage_over_lowest_price) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                    }
                }
                if (sv_1.total_local_storage_gb) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.v_cpu_count) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.max) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.VCpuCount.Max=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_2.min) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceRequirements.VCpuCount.Min=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.instance_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.InstanceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.kernel_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.KernelId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.KeyName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.monitoring) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.enabled) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.Monitoring.Enabled=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                    }
                }
            }
            if (item.network_interfaces) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.associate_carrier_ip_address) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.AssociateCarrierIpAddress=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.associate_public_ip_address) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.AssociatePublicIpAddress=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    if (item_1.connection_tracking_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.tcp_established_timeout) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.ConnectionTrackingSpecification.TcpEstablishedTimeout=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.udp_stream_timeout) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.ConnectionTrackingSpecification.UdpStreamTimeout=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.udp_timeout) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.ConnectionTrackingSpecification.UdpTimeout=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.delete_on_termination) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.DeleteOnTermination=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.description) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Description=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.device_index) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.DeviceIndex=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.ena_queue_count) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.EnaQueueCount=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ena_srd_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.ena_srd_enabled) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.EnaSrdSpecification.EnaSrdEnabled=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        if (sv_2.ena_srd_udp_specification) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.ena_srd_udp_enabled) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_4) "true" else "false");
                                }
                            }
                        }
                    }
                    if (item_1.groups) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.SecurityGroupId.{d}=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_2);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.interface_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.InterfaceType=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.ipv_4_prefix_count) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv4PrefixCount=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ipv_4_prefixes) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.ipv_4_prefix) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv4Prefix.{d}.Ipv4Prefix=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.ipv_6_address_count) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv6AddressCount=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ipv_6_addresses) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.ipv_6_address) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv6Addresses.{d}.Ipv6Address=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.is_primary_ipv_6) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv6Addresses.{d}.IsPrimaryIpv6=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.ipv_6_prefix_count) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv6PrefixCount=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ipv_6_prefixes) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.ipv_6_prefix) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.Ipv6Prefix.{d}.Ipv6Prefix=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.network_card_index) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.NetworkCardIndex=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.network_interface_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.NetworkInterfaceId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.primary_ipv_6) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.PrimaryIpv6=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.private_ip_address) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.PrivateIpAddress=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item_1.private_ip_addresses) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.primary) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.PrivateIpAddresses.{d}.Primary=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.private_ip_address) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.PrivateIpAddresses.{d}.PrivateIpAddress=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.secondary_private_ip_address_count) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.SecondaryPrivateIpAddressCount=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.subnet_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.NetworkInterfaceSet.{d}.SubnetId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            if (item.placement) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.availability_zone) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.Placement.AvailabilityZone=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.availability_zone_id) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.Placement.AvailabilityZoneId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.group_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.Placement.GroupName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.tenancy) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.Placement.Tenancy=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.ramdisk_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.RamdiskId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.security_groups) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.group_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.GroupSet.{d}.GroupId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.group_name) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.GroupSet.{d}.GroupName=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.spot_price) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.SpotPrice=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.subnet_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.SubnetId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.tag_specifications) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.resource_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.TagSpecificationSet.{d}.ResourceType=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                        }
                    }
                    if (item_1.tags) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.key) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.TagSpecificationSet.{d}.Tag.{d}.Key=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.value) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.TagSpecificationSet.{d}.Tag.{d}.Value=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.user_data) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.UserData=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.weighted_capacity) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.{d}.WeightedCapacity=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
        }
    }
    if (input.spot_fleet_request_config.launch_template_configs) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            if (item.launch_template_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.launch_template_id) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.launch_template_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.version) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
            }
            if (item.overrides) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.availability_zone) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.AvailabilityZone=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.availability_zone_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.AvailabilityZoneId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item_1.instance_requirements) |sv_2| {
                        if (sv_2.accelerator_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.accelerator_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorManufacturerSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.accelerator_names) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorNameSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.accelerator_total_memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.accelerator_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AcceleratorTypeSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.allowed_instance_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.AllowedInstanceTypeSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.bare_metal) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.BareMetal=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.baseline_ebs_bandwidth_mbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.baseline_performance_factors) |sv_3| {
                            if (sv_3.cpu) |sv_4| {
                                if (sv_4.references) |lst_5| {
                                    for (lst_5, 0..) |item_5, idx_5| {
                                        const n_5 = idx_5 + 1;
                                        {
                                            var prefix_buf: [256]u8 = undefined;
                                            if (item_5.instance_family) |fv_6| {
                                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.ReferenceSet.{d}.InstanceFamily=", .{n, n_1, n_5}) catch continue;
                                                try body_buf.appendSlice(allocator, field_prefix);
                                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_6);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.burstable_performance) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.BurstablePerformance=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.cpu_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.CpuManufacturerSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.excluded_instance_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.ExcludedInstanceTypeSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.instance_generations) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.InstanceGenerationSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.local_storage) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.LocalStorage=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.local_storage_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.LocalStorageTypeSet.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.memory_gi_b_per_v_cpu) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.MemoryMiB.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.MemoryMiB.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.network_bandwidth_gbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.network_interface_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.on_demand_max_price_percentage_over_lowest_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.require_encryption_in_transit) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.RequireEncryptionInTransit=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.require_hibernate_support) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.RequireHibernateSupport=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.spot_max_price_percentage_over_lowest_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.total_local_storage_gb) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.v_cpu_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.VCpuCount.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceRequirements.VCpuCount.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.instance_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.InstanceType=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.priority) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.Priority=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.spot_price) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.SpotPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.subnet_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.SubnetId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.weighted_capacity) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.{d}.Overrides.{d}.WeightedCapacity=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                }
            }
        }
    }
    if (input.spot_fleet_request_config.load_balancers_config) |sv| {
        if (sv.classic_load_balancers_config) |sv2| {
            if (sv2.classic_load_balancers) |list_d2| {
                for (list_d2, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.name) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LoadBalancersConfig.ClassicLoadBalancersConfig.ClassicLoadBalancers.{d}.Name=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
            }
        }
        if (sv.target_groups_config) |sv2| {
            if (sv2.target_groups) |list_d2| {
                for (list_d2, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.arn) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LoadBalancersConfig.TargetGroupsConfig.TargetGroups.{d}.Arn=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
            }
        }
    }
    if (input.spot_fleet_request_config.on_demand_allocation_strategy) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.OnDemandAllocationStrategy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.spot_fleet_request_config.on_demand_fulfilled_capacity) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.OnDemandFulfilledCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.on_demand_max_total_price) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.OnDemandMaxTotalPrice=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.on_demand_target_capacity) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.OnDemandTargetCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.replace_unhealthy_instances) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.ReplaceUnhealthyInstances=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.spot_fleet_request_config.spot_maintenance_strategies) |sv| {
        if (sv.capacity_rebalance) |sv2| {
            if (sv2.replacement_strategy) |sv3| {
                try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.SpotMaintenanceStrategies.CapacityRebalance.ReplacementStrategy=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv3.wireName());
            }
            if (sv2.termination_delay) |sv3| {
                try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.SpotMaintenanceStrategies.CapacityRebalance.TerminationDelay=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
            }
        }
    }
    if (input.spot_fleet_request_config.spot_max_total_price) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.SpotMaxTotalPrice=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.spot_price) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.SpotPrice=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.tag_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.TargetCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.spot_fleet_request_config.target_capacity}) catch "");
    if (input.spot_fleet_request_config.target_capacity_unit_type) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.TargetCapacityUnitType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.spot_fleet_request_config.terminate_instances_with_expiration) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.TerminateInstancesWithExpiration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.spot_fleet_request_config.@"type") |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.spot_fleet_request_config.valid_from) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.ValidFrom=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.valid_until) |sv| {
        try body_buf.appendSlice(allocator, "&SpotFleetRequestConfig.ValidUntil=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RequestSpotFleetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RequestSpotFleetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "spotFleetRequestId")) {
                    result.spot_fleet_request_id = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
