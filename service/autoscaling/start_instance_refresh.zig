const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DesiredConfiguration = @import("desired_configuration.zig").DesiredConfiguration;
const RefreshPreferences = @import("refresh_preferences.zig").RefreshPreferences;
const RefreshStrategy = @import("refresh_strategy.zig").RefreshStrategy;
const serde = @import("serde.zig");

pub const StartInstanceRefreshInput = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The desired configuration. For example, the desired configuration can
    /// specify a new
    /// launch template or a new version of the current launch template.
    ///
    /// Once the instance refresh succeeds, Amazon EC2 Auto Scaling updates the
    /// settings of the Auto Scaling group to
    /// reflect the new desired configuration.
    ///
    /// When you specify a new launch template or a new version of the current
    /// launch
    /// template for your desired configuration, consider enabling the
    /// `SkipMatching` property in preferences. If it's enabled, Amazon EC2 Auto
    /// Scaling
    /// skips replacing instances that already use the specified launch template and
    /// instance types. This can help you reduce the number of replacements that are
    /// required to apply updates.
    desired_configuration: ?DesiredConfiguration = null,

    /// Sets your preferences for the instance refresh so that it performs as
    /// expected when
    /// you start it. Includes the instance warmup time, the minimum and maximum
    /// healthy
    /// percentages, and the behaviors that you want Amazon EC2 Auto Scaling to use
    /// if instances that are in
    /// `Standby` state or protected from scale in are found. You can also choose
    /// to enable additional features, such as the following:
    ///
    /// * Auto rollback
    ///
    /// * Checkpoints
    ///
    /// * CloudWatch alarms
    ///
    /// * Skip matching
    ///
    /// * Bake time
    preferences: ?RefreshPreferences = null,

    /// The strategy to use for the instance refresh. The default value is
    /// `Rolling`.
    strategy: ?RefreshStrategy = null,
};

pub const StartInstanceRefreshOutput = struct {
    /// A unique ID for tracking the progress of the instance refresh.
    instance_refresh_id: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartInstanceRefreshInput, options: Options) !StartInstanceRefreshOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "autoscaling");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartInstanceRefreshInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling", "Auto Scaling", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=StartInstanceRefresh&Version=2011-01-01");
    try body_buf.appendSlice(alloc, "&AutoScalingGroupName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.auto_scaling_group_name);
    if (input.desired_configuration) |v| {
        if (v.launch_template) |sv| {
            if (sv.launch_template_id) |sv2| {
                try body_buf.appendSlice(alloc, "&DesiredConfiguration.LaunchTemplate.LaunchTemplateId=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.launch_template_name) |sv2| {
                try body_buf.appendSlice(alloc, "&DesiredConfiguration.LaunchTemplate.LaunchTemplateName=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
            if (sv.version) |sv2| {
                try body_buf.appendSlice(alloc, "&DesiredConfiguration.LaunchTemplate.Version=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
            }
        }
        if (v.mixed_instances_policy) |sv| {
            if (sv.instances_distribution) |sv2| {
                if (sv2.on_demand_allocation_strategy) |sv3| {
                    try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.InstancesDistribution.OnDemandAllocationStrategy=");
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
                }
                if (sv2.on_demand_base_capacity) |sv3| {
                    try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.InstancesDistribution.OnDemandBaseCapacity=");
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
                }
                if (sv2.on_demand_percentage_above_base_capacity) |sv3| {
                    try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.InstancesDistribution.OnDemandPercentageAboveBaseCapacity=");
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
                }
                if (sv2.spot_allocation_strategy) |sv3| {
                    try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.InstancesDistribution.SpotAllocationStrategy=");
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
                }
                if (sv2.spot_instance_pools) |sv3| {
                    try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.InstancesDistribution.SpotInstancePools=");
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
                }
                if (sv2.spot_max_price) |sv3| {
                    try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.InstancesDistribution.SpotMaxPrice=");
                    try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
                }
            }
            if (sv.launch_template) |sv2| {
                if (sv2.launch_template_specification) |sv3| {
                    if (sv3.launch_template_id) |sv4| {
                        try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.LaunchTemplateSpecification.LaunchTemplateId=");
                        try aws.url.appendUrlEncoded(alloc, &body_buf, sv4);
                    }
                    if (sv3.launch_template_name) |sv4| {
                        try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.LaunchTemplateSpecification.LaunchTemplateName=");
                        try aws.url.appendUrlEncoded(alloc, &body_buf, sv4);
                    }
                    if (sv3.version) |sv4| {
                        try body_buf.appendSlice(alloc, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.LaunchTemplateSpecification.Version=");
                        try aws.url.appendUrlEncoded(alloc, &body_buf, sv4);
                    }
                }
                if (sv2.overrides) |list_d2| {
                    for (list_d2, 0..) |item, idx| {
                        const n = idx + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.ImageId=", .{n}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item.image_id) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        if (item.instance_requirements) |sv_3| {
                            if (sv_3.accelerator_count) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorCount.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorCount.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                            }
                            if (sv_3.accelerator_manufacturers) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorManufacturers.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            if (sv_3.accelerator_names) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorNames.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            if (sv_3.accelerator_total_memory_mi_b) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                            }
                            if (sv_3.accelerator_types) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AcceleratorTypes.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            if (sv_3.allowed_instance_types) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.AllowedInstanceTypes.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BareMetal=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.bare_metal) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_4));
                                }
                            }
                            if (sv_3.baseline_ebs_bandwidth_mbps) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselineEbsBandwidthMbps.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                            }
                            if (sv_3.baseline_performance_factors) |sv_4| {
                                if (sv_4.cpu) |sv_5| {
                                    if (sv_5.references) |lst_6| {
                                        for (lst_6, 0..) |item_6, idx_6| {
                                            const n_6 = idx_6 + 1;
                                            {
                                                var prefix_buf: [256]u8 = undefined;
                                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{ n, n_6 }) catch continue;
                                                try body_buf.appendSlice(alloc, field_prefix);
                                                if (item_6.instance_family) |fv_7| {
                                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_7);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.BurstablePerformance=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.burstable_performance) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_4));
                                }
                            }
                            if (sv_3.cpu_manufacturers) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.CpuManufacturers.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            if (sv_3.excluded_instance_types) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.ExcludedInstanceTypes.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            if (sv_3.instance_generations) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.InstanceGenerations.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.LocalStorage=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.local_storage) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_4));
                                }
                            }
                            if (sv_3.local_storage_types) |lst_4| {
                                for (lst_4, 0..) |item_4, idx_4| {
                                    const n_4 = idx_4 + 1;
                                    {
                                        var prefix_buf: [256]u8 = undefined;
                                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.LocalStorageTypes.member.{d}=", .{ n, n_4 }) catch continue;
                                        try body_buf.appendSlice(alloc, field_prefix);
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_4);
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.max_spot_price_as_percentage_of_optimal_on_demand_price) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            if (sv_3.memory_gi_b_per_v_cpu) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryGiBPerVCpu.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryGiBPerVCpu.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryMiB.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.memory_mi_b.max) |fv_5| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.MemoryMiB.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv_3.memory_mi_b.min}) catch "");
                            }
                            if (sv_3.network_bandwidth_gbps) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkBandwidthGbps.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkBandwidthGbps.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                            }
                            if (sv_3.network_interface_count) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkInterfaceCount.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.NetworkInterfaceCount.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.on_demand_max_price_percentage_over_lowest_price) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.RequireHibernateSupport=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.require_hibernate_support) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_4) "true" else "false");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.spot_max_price_percentage_over_lowest_price) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_4}) catch "");
                                }
                            }
                            if (sv_3.total_local_storage_gb) |sv_4| {
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.TotalLocalStorageGB.Max=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.max) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.TotalLocalStorageGB.Min=", .{n}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    if (sv_4.min) |fv_5| {
                                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_5);
                                    }
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.VCpuCount.Max=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.v_cpu_count.max) |fv_5| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_5}) catch "");
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceRequirements.VCpuCount.Min=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv_3.v_cpu_count.min}) catch "");
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.InstanceType=", .{n}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item.instance_type) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                        if (item.launch_template_specification) |sv_3| {
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.LaunchTemplateId=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.launch_template_id) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.LaunchTemplateName=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.launch_template_name) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.LaunchTemplateSpecification.Version=", .{n}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                if (sv_3.version) |fv_4| {
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                                }
                            }
                        }
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DesiredConfiguration.MixedInstancesPolicy.LaunchTemplate.Overrides.member.{d}.WeightedCapacity=", .{n}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item.weighted_capacity) |fv_3| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_3);
                            }
                        }
                    }
                }
            }
        }
    }
    if (input.preferences) |v| {
        if (v.alarm_specification) |sv| {
            if (sv.alarms) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Preferences.AlarmSpecification.Alarms.member.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    try aws.url.appendUrlEncoded(alloc, &body_buf, item);
                }
            }
        }
        if (v.auto_rollback) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.AutoRollback=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.bake_time) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.BakeTime=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.checkpoint_delay) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.CheckpointDelay=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.checkpoint_percentages) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Preferences.CheckpointPercentages.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (v.instance_warmup) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.InstanceWarmup=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.max_healthy_percentage) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.MaxHealthyPercentage=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.min_healthy_percentage) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.MinHealthyPercentage=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.scale_in_protected_instances) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.ScaleInProtectedInstances=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.skip_matching) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.SkipMatching=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.standby_instances) |sv| {
            try body_buf.appendSlice(alloc, "&Preferences.StandbyInstances=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.strategy) |v| {
        try body_buf.appendSlice(alloc, "&Strategy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartInstanceRefreshOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StartInstanceRefreshResult")) break;
            },
            else => {},
        }
    }

    var result: StartInstanceRefreshOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "InstanceRefreshId")) {
                    result.instance_refresh_id = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ActiveInstanceRefreshNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .active_instance_refresh_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchError")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceRefreshInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .instance_refresh_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IrreversibleInstanceRefreshFault")) {
        return .{ .arena = arena, .kind = .{ .irreversible_instance_refresh_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceContentionFault")) {
        return .{ .arena = arena, .kind = .{ .resource_contention_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseFault")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScalingActivityInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .scaling_activity_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleFailure")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_failure = .{
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
