const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RequestSpotFleetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RequestSpotFleetInput, options: Options) !RequestSpotFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RequestSpotFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RequestSpotFleet&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.spot_fleet_request_config.allocation_strategy) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.AllocationStrategy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.client_token) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.context) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.Context=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.excess_capacity_termination_policy) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ExcessCapacityTerminationPolicy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.fulfilled_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.FulfilledCapacity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.IamFleetRole=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.spot_fleet_request_config.iam_fleet_role);
    if (input.spot_fleet_request_config.instance_interruption_behavior) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.InstanceInterruptionBehavior=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.instance_pools_to_use_count) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.InstancePoolsToUseCount=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.launch_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.AddressingType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.addressing_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.block_device_mappings) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.DeviceName=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.device_name) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.ebs) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.AvailabilityZone=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.availability_zone) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.AvailabilityZoneId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.availability_zone_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.DeleteOnTermination=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.delete_on_termination) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.EbsCardIndex=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.ebs_card_index) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.Encrypted=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.encrypted) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.Iops=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.iops) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.KmsKeyId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.kms_key_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.OutpostArn=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.outpost_arn) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.SnapshotId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.snapshot_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.Throughput=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.throughput) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.VolumeInitializationRate=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.volume_initialization_rate) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.VolumeSize=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.volume_size) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.Ebs.VolumeType=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.volume_type) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_3));
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.NoDevice=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.no_device) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.BlockDeviceMappings.item.{d}.VirtualName=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.virtual_name) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.EbsOptimized=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ebs_optimized) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            if (item.iam_instance_profile) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.IamInstanceProfile.Arn=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.arn) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.IamInstanceProfile.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.name) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.ImageId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.image_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.instance_requirements) |sv_1| {
                if (sv_1.accelerator_count) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.accelerator_manufacturers) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorManufacturers.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.accelerator_names) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorNames.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.accelerator_total_memory_mi_b) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.accelerator_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AcceleratorTypes.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.allowed_instance_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.AllowedInstanceTypes.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.BareMetal=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.bare_metal) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
                if (sv_1.baseline_ebs_bandwidth_mbps) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{n, n_4}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (item_4.instance_family) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                            }
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.BurstablePerformance=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.burstable_performance) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
                if (sv_1.cpu_manufacturers) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.CpuManufacturers.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.excluded_instance_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.ExcludedInstanceTypes.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                if (sv_1.instance_generations) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.InstanceGenerations.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.LocalStorage=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.local_storage) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
                if (sv_1.local_storage_types) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.LocalStorageTypes.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                if (sv_1.memory_gi_b_per_v_cpu) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                }
                if (sv_1.memory_mi_b) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.MemoryMiB.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.MemoryMiB.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                if (sv_1.network_bandwidth_gbps) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                }
                if (sv_1.network_interface_count) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.on_demand_max_price_percentage_over_lowest_price) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.RequireEncryptionInTransit=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.require_encryption_in_transit) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.RequireHibernateSupport=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.require_hibernate_support) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.spot_max_price_percentage_over_lowest_price) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                if (sv_1.total_local_storage_gb) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                }
                if (sv_1.v_cpu_count) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.VCpuCount.Max=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.max) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceRequirements.VCpuCount.Min=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (sv_2.min) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.InstanceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.instance_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.KernelId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.kernel_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.KeyName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.monitoring) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.Monitoring.Enabled=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.enabled) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
            }
            if (item.network_interfaces) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.AssociateCarrierIpAddress=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.associate_carrier_ip_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.AssociatePublicIpAddress=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.associate_public_ip_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    if (item_1.connection_tracking_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.ConnectionTrackingSpecification.TcpEstablishedTimeout=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.tcp_established_timeout) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.ConnectionTrackingSpecification.UdpStreamTimeout=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.udp_stream_timeout) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.ConnectionTrackingSpecification.UdpTimeout=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.udp_timeout) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.DeleteOnTermination=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.delete_on_termination) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.description) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.DeviceIndex=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.device_index) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.EnaQueueCount=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ena_queue_count) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ena_srd_specification) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.EnaSrdSpecification.EnaSrdEnabled=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.ena_srd_enabled) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        if (sv_2.ena_srd_udp_specification) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.ena_srd_udp_enabled) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_4) "true" else "false");
                                }
                            }
                        }
                    }
                    if (item_1.groups) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Groups.SecurityGroupId.{d}=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.InterfaceType=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.interface_type) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv4PrefixCount=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_4_prefix_count) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ipv_4_prefixes) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv4Prefixes.item.{d}.Ipv4Prefix=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.ipv_4_prefix) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv6AddressCount=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_6_address_count) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ipv_6_addresses) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv6Addresses.item.{d}.Ipv6Address=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.ipv_6_address) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv6Addresses.item.{d}.IsPrimaryIpv6=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.is_primary_ipv_6) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv6PrefixCount=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_6_prefix_count) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    if (item_1.ipv_6_prefixes) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.Ipv6Prefixes.item.{d}.Ipv6Prefix=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.ipv_6_prefix) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.NetworkCardIndex=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.network_card_index) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.NetworkInterfaceId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.network_interface_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.PrimaryIpv6=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.primary_ipv_6) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.PrivateIpAddress=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.private_ip_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.private_ip_addresses) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.PrivateIpAddresses.item.{d}.Primary=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.primary) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.PrivateIpAddresses.item.{d}.PrivateIpAddress=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.private_ip_address) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.SecondaryPrivateIpAddressCount=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.secondary_private_ip_address_count) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.NetworkInterfaces.item.{d}.SubnetId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.subnet_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            if (item.placement) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.Placement.AvailabilityZone=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.availability_zone) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.Placement.AvailabilityZoneId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.availability_zone_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.Placement.GroupName=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.group_name) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.Placement.Tenancy=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.tenancy) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.RamdiskId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ramdisk_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.security_groups) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.SecurityGroups.item.{d}.GroupId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.group_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.SecurityGroups.item.{d}.GroupName=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.group_name) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.SpotPrice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.spot_price) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.subnet_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.tag_specifications) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.TagSpecifications.item.{d}.ResourceType=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.resource_type) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                        }
                    }
                    if (item_1.tags) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.key) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.value) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.UserData=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.user_data) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchSpecifications.item.{d}.WeightedCapacity=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.weighted_capacity) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.launch_template_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.launch_template_name) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.version) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
            }
            if (item.overrides) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.AvailabilityZone=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.availability_zone) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.AvailabilityZoneId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.availability_zone_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.instance_requirements) |sv_2| {
                        if (sv_2.accelerator_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.accelerator_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorManufacturers.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.accelerator_names) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorNames.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.accelerator_total_memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.accelerator_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.allowed_instance_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.AllowedInstanceTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.BareMetal=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.bare_metal) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.baseline_ebs_bandwidth_mbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
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
                                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{n, n_1, n_5}) catch continue;
                                            try body_buf.appendSlice(alloc, field_prefix);
                                            if (item_5.instance_family) |fv_6| {
                                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_6);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.BurstablePerformance=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.burstable_performance) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.cpu_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.CpuManufacturers.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.excluded_instance_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.ExcludedInstanceTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.instance_generations) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.InstanceGenerations.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.LocalStorage=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.local_storage) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.local_storage_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.LocalStorageTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.memory_gi_b_per_v_cpu) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        if (sv_2.memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryMiB.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryMiB.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.network_bandwidth_gbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        if (sv_2.network_interface_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.on_demand_max_price_percentage_over_lowest_price) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.RequireEncryptionInTransit=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.require_encryption_in_transit) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.RequireHibernateSupport=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.require_hibernate_support) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.spot_max_price_percentage_over_lowest_price) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.total_local_storage_gb) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        if (sv_2.v_cpu_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.VCpuCount.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceRequirements.VCpuCount.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.InstanceType=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.instance_type) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.Priority=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.priority) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.SpotPrice=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.spot_price) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.SubnetId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.subnet_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LaunchTemplateConfigs.item.{d}.Overrides.item.{d}.WeightedCapacity=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.weighted_capacity) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LoadBalancersConfig.ClassicLoadBalancersConfig.ClassicLoadBalancers.item.{d}.Name=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item.name) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.LoadBalancersConfig.TargetGroupsConfig.TargetGroups.item.{d}.Arn=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item.arn) |fv_3| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                }
            }
        }
    }
    if (input.spot_fleet_request_config.on_demand_allocation_strategy) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandAllocationStrategy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.on_demand_fulfilled_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandFulfilledCapacity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.on_demand_max_total_price) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandMaxTotalPrice=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.on_demand_target_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandTargetCapacity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.replace_unhealthy_instances) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ReplaceUnhealthyInstances=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.spot_fleet_request_config.spot_maintenance_strategies) |sv| {
        if (sv.capacity_rebalance) |sv2| {
            if (sv2.replacement_strategy) |sv3| {
                try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.SpotMaintenanceStrategies.CapacityRebalance.ReplacementStrategy=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv3));
            }
            if (sv2.termination_delay) |sv3| {
                try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.SpotMaintenanceStrategies.CapacityRebalance.TerminationDelay=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
        }
    }
    if (input.spot_fleet_request_config.spot_max_total_price) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.SpotMaxTotalPrice=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.spot_price) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.SpotPrice=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.tag_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SpotFleetRequestConfig.TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.TargetCapacity=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.spot_fleet_request_config.target_capacity}) catch "");
    if (input.spot_fleet_request_config.target_capacity_unit_type) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.TargetCapacityUnitType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.terminate_instances_with_expiration) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.TerminateInstancesWithExpiration=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.spot_fleet_request_config.@"type") |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.Type=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.valid_from) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ValidFrom=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.valid_until) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ValidUntil=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RequestSpotFleetOutput {
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
                    result.spot_fleet_request_id = try alloc.dupe(u8, try reader.readElementText());
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
