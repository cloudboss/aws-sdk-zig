const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FleetExcessCapacityTerminationPolicy = @import("fleet_excess_capacity_termination_policy.zig").FleetExcessCapacityTerminationPolicy;
const FleetLaunchTemplateConfigRequest = @import("fleet_launch_template_config_request.zig").FleetLaunchTemplateConfigRequest;
const TargetCapacitySpecificationRequest = @import("target_capacity_specification_request.zig").TargetCapacitySpecificationRequest;
const serde = @import("serde.zig");

pub const ModifyFleetInput = struct {
    /// Reserved.
    context: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether running instances should be terminated if the total target
    /// capacity of
    /// the EC2 Fleet is decreased below the current size of the EC2 Fleet.
    ///
    /// Supported only for fleets of type `maintain`.
    excess_capacity_termination_policy: ?FleetExcessCapacityTerminationPolicy = null,

    /// The ID of the EC2 Fleet.
    fleet_id: []const u8,

    /// The launch template and overrides.
    launch_template_configs: ?[]const FleetLaunchTemplateConfigRequest = null,

    /// The size of the EC2 Fleet.
    target_capacity_specification: ?TargetCapacitySpecificationRequest = null,
};

pub const ModifyFleetOutput = struct {
    /// If the request succeeds, the response returns `true`. If the request fails,
    /// no response is returned, and instead an error message is returned.
    @"return": ?bool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyFleetInput, options: CallOptions) !ModifyFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyFleet&Version=2016-11-15");
    if (input.context) |v| {
        try body_buf.appendSlice(allocator, "&Context=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.excess_capacity_termination_policy) |v| {
        try body_buf.appendSlice(allocator, "&ExcessCapacityTerminationPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&FleetId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.fleet_id);
    if (input.launch_template_configs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.launch_template_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.launch_template_id) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.launch_template_name) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (sv_1.version) |fv_2| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
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
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.AvailabilityZone=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.availability_zone_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.AvailabilityZoneId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item_1.block_device_mappings) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.device_name) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.DeviceName=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                            if (item_2.ebs) |sv_3| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.delete_on_termination) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_4) "true" else "false");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.encrypted) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_4) "true" else "false");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.iops) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.Iops=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.kms_key_id) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.KmsKeyId=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.snapshot_id) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.throughput) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.Throughput=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.volume_size) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    if (sv_3.volume_type) |fv_4| {
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n, n_1, n_2}) catch continue;
                                        try body_buf.appendSlice(allocator, field_prefix);
                                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4.wireName());
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.no_device) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.NoDevice=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item_2.virtual_name) |fv_3| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.BlockDeviceMapping.{d}.VirtualName=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.image_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.ImageId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item_1.instance_requirements) |sv_2| {
                        if (sv_2.accelerator_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n, n_1}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorManufacturer.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorName.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        if (sv_2.accelerator_total_memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n, n_1}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AcceleratorType.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.AllowedInstanceType.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.bare_metal) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.BareMetal=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.baseline_ebs_bandwidth_mbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n, n_1}) catch continue;
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
                                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.Reference.{d}.InstanceFamily=", .{n, n_1, n_5}) catch continue;
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.BurstablePerformance=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.cpu_manufacturers) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.CpuManufacturer.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.ExcludedInstanceType.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.InstanceGeneration.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.local_storage) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.LocalStorage=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                        if (sv_2.local_storage_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.LocalStorageType.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.memory_gi_b_per_v_cpu) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.memory_mi_b.max) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.MemoryMiB.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.MemoryMiB.Min=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_2.memory_mi_b.min}) catch "");
                        }
                        if (sv_2.network_bandwidth_gbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        if (sv_2.network_interface_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.on_demand_max_price_percentage_over_lowest_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.require_encryption_in_transit) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.RequireEncryptionInTransit=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.require_hibernate_support) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.RequireHibernateSupport=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.spot_max_price_percentage_over_lowest_price) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.total_local_storage_gb) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.max) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (sv_3.min) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n, n_1}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.v_cpu_count.max) |fv_4| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.VCpuCount.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_4}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceRequirements.VCpuCount.Min=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_2.v_cpu_count.min}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.instance_type) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.InstanceType=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.max_price) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.MaxPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    if (item_1.placement) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.affinity) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.Affinity=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.availability_zone) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.AvailabilityZone=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.availability_zone_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.AvailabilityZoneId=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.group_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.GroupId=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.group_name) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.GroupName=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.host_id) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.HostId=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.host_resource_group_arn) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.HostResourceGroupArn=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.partition_number) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.PartitionNumber=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.spread_domain) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.SpreadDomain=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            if (sv_2.tenancy) |fv_3| {
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Placement.Tenancy=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3.wireName());
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.priority) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.Priority=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.subnet_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.SubnetId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.weighted_capacity) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.{d}.Overrides.{d}.WeightedCapacity=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_2}) catch "");
                        }
                    }
                }
            }
        }
    }
    if (input.target_capacity_specification) |v| {
        if (v.default_target_capacity_type) |sv| {
            try body_buf.appendSlice(allocator, "&TargetCapacitySpecification.DefaultTargetCapacityType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.on_demand_target_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&TargetCapacitySpecification.OnDemandTargetCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.spot_target_capacity) |sv| {
            try body_buf.appendSlice(allocator, "&TargetCapacitySpecification.SpotTargetCapacity=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.target_capacity_unit_type) |sv| {
            try body_buf.appendSlice(allocator, "&TargetCapacitySpecification.TargetCapacityUnitType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        try body_buf.appendSlice(allocator, "&TargetCapacitySpecification.TotalTargetCapacity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v.total_target_capacity}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyFleetOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyFleetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
