const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyFleetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyFleetInput, options: Options) !ModifyFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyFleet&Version=2016-11-15");
    if (input.context) |v| {
        try body_buf.appendSlice(alloc, "&Context=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.excess_capacity_termination_policy) |v| {
        try body_buf.appendSlice(alloc, "&ExcessCapacityTerminationPolicy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&FleetId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.fleet_id);
    if (input.launch_template_configs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.launch_template_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.launch_template_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.launch_template_name) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.AvailabilityZone=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.availability_zone) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.AvailabilityZoneId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.availability_zone_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.block_device_mappings) |lst_2| {
                        for (lst_2, 0..) |item_2, idx_2| {
                            const n_2 = idx_2 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.DeviceName=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.device_name) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                            if (item_2.ebs) |sv_3| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.delete_on_termination) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_4) "true" else "false");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.encrypted) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_4) "true" else "false");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Iops=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.iops) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.KmsKeyId=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.kms_key_id) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.snapshot_id) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Throughput=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.throughput) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.volume_size) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n, n_1, n_2}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_3.volume_type) |fv_4| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_4));
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.NoDevice=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.no_device) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.BlockDeviceMappings.BlockDeviceMapping.{d}.VirtualName=", .{n, n_1, n_2}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (item_2.virtual_name) |fv_3| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                                }
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.ImageId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.image_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.instance_requirements) |sv_2| {
                        if (sv_2.accelerator_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n, n_1}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorManufacturers.item.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorNames.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.accelerator_total_memory_mi_b) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n, n_1}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AcceleratorTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.AllowedInstanceTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.BareMetal=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.bare_metal) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_3));
                            }
                        }
                        if (sv_2.baseline_ebs_bandwidth_mbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n, n_1}) catch continue;
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
                                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{n, n_1, n_5}) catch continue;
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
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.BurstablePerformance=", .{n, n_1}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.CpuManufacturers.item.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.ExcludedInstanceTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.InstanceGenerations.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.LocalStorage=", .{n, n_1}) catch continue;
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.LocalStorageTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.memory_gi_b_per_v_cpu) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryMiB.Max=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.memory_mi_b.max) |fv_4| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.MemoryMiB.Min=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv_2.memory_mi_b.min}) catch "");
                        }
                        if (sv_2.network_bandwidth_gbps) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        if (sv_2.network_interface_count) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.on_demand_max_price_percentage_over_lowest_price) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.RequireEncryptionInTransit=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.require_encryption_in_transit) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.RequireHibernateSupport=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.require_hibernate_support) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_3) "true" else "false");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.spot_max_price_percentage_over_lowest_price) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        if (sv_2.total_local_storage_gb) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n, n_1}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.min) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.VCpuCount.Max=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.v_cpu_count.max) |fv_4| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceRequirements.VCpuCount.Min=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv_2.v_cpu_count.min}) catch "");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.InstanceType=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.instance_type) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.MaxPrice=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.max_price) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    if (item_1.placement) |sv_2| {
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.Affinity=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.affinity) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.AvailabilityZone=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.availability_zone) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.AvailabilityZoneId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.availability_zone_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.GroupId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.group_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.GroupName=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.group_name) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.HostId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.host_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.HostResourceGroupArn=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.host_resource_group_arn) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.PartitionNumber=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.partition_number) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_3}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.SpreadDomain=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.spread_domain) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Placement.Tenancy=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (sv_2.tenancy) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_3));
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.Priority=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.priority) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.SubnetId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.subnet_id) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateConfig.item.{d}.Overrides.item.{d}.WeightedCapacity=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.weighted_capacity) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.target_capacity_specification) |v| {
        if (v.default_target_capacity_type) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.DefaultTargetCapacityType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.on_demand_target_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.OnDemandTargetCapacity=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.spot_target_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.SpotTargetCapacity=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.target_capacity_unit_type) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.TargetCapacityUnitType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.TotalTargetCapacity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v.total_target_capacity}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyFleetOutput {
    _ = status;
    _ = headers;
    _ = alloc;
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
