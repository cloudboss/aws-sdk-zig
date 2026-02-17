const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RequestLaunchTemplateData = @import("request_launch_template_data.zig").RequestLaunchTemplateData;
const OperatorRequest = @import("operator_request.zig").OperatorRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;
const ValidationWarning = @import("validation_warning.zig").ValidationWarning;
const serde = @import("serde.zig");

pub const CreateLaunchTemplateInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the
    /// request. If a client token isn't specified, a randomly generated token is
    /// used in the
    /// request to ensure idempotency.
    ///
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    ///
    /// Constraint: Maximum 128 ASCII characters.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The information for the launch template.
    launch_template_data: RequestLaunchTemplateData,

    /// A name for the launch template.
    launch_template_name: []const u8,

    /// Reserved for internal use.
    operator: ?OperatorRequest = null,

    /// The tags to apply to the launch template on creation. To tag the launch
    /// template, the
    /// resource type must be `launch-template`.
    ///
    /// To specify the tags for the resources that are created when an instance is
    /// launched,
    /// you must use the `TagSpecifications` parameter in the [launch template
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RequestLaunchTemplateData.html) structure.
    tag_specifications: ?[]const TagSpecification = null,

    /// A description for the first version of the launch template.
    version_description: ?[]const u8 = null,
};

pub const CreateLaunchTemplateOutput = struct {
    /// Information about the launch template.
    launch_template: ?LaunchTemplate = null,

    /// If the launch template contains parameters or parameter combinations that
    /// are not
    /// valid, an error code and an error message are returned for each issue that's
    /// found.
    warning: ?ValidationWarning = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateLaunchTemplateOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateLaunchTemplateInput, options: Options) !CreateLaunchTemplateOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLaunchTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateLaunchTemplate&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.launch_template_data.block_device_mappings) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.ebs) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.DeleteOnTermination=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.delete_on_termination) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.EbsCardIndex=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.ebs_card_index) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Encrypted=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.encrypted) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Iops=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.iops) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.KmsKeyId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.kms_key_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.SnapshotId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.snapshot_id) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.Throughput=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.throughput) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeInitializationRate=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_initialization_rate) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeSize=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_size) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.Ebs.VolumeType=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.volume_type) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.BlockDeviceMappings.BlockDeviceMapping.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.launch_template_data.capacity_reservation_specification) |sv| {
        if (sv.capacity_reservation_preference) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.CapacityReservationSpecification.CapacityReservationPreference=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.capacity_reservation_target) |sv2| {
            if (sv2.capacity_reservation_id) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.CapacityReservationSpecification.CapacityReservationTarget.CapacityReservationId=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
            if (sv2.capacity_reservation_resource_group_arn) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.CapacityReservationSpecification.CapacityReservationTarget.CapacityReservationResourceGroupArn=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
        }
    }
    if (input.launch_template_data.cpu_options) |sv| {
        if (sv.amd_sev_snp) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.CpuOptions.AmdSevSnp=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.core_count) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.CpuOptions.CoreCount=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.threads_per_core) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.CpuOptions.ThreadsPerCore=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
    }
    if (input.launch_template_data.credit_specification) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.CreditSpecification.CpuCredits=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv.cpu_credits);
    }
    if (input.launch_template_data.disable_api_stop) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.DisableApiStop=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_template_data.disable_api_termination) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.DisableApiTermination=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_template_data.ebs_optimized) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.EbsOptimized=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.launch_template_data.elastic_gpu_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.ElasticGpuSpecifications.ElasticGpuSpecification.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.@"type");
            }
        }
    }
    if (input.launch_template_data.elastic_inference_accelerators) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.ElasticInferenceAccelerators.item.{d}.Count=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.count) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.ElasticInferenceAccelerators.item.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.@"type");
            }
        }
    }
    if (input.launch_template_data.enclave_options) |sv| {
        if (sv.enabled) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.EnclaveOptions.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
    }
    if (input.launch_template_data.hibernation_options) |sv| {
        if (sv.configured) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.HibernationOptions.Configured=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
    }
    if (input.launch_template_data.iam_instance_profile) |sv| {
        if (sv.arn) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.IamInstanceProfile.Arn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.name) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.IamInstanceProfile.Name=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    if (input.launch_template_data.image_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.ImageId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.instance_initiated_shutdown_behavior) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceInitiatedShutdownBehavior=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.launch_template_data.instance_market_options) |sv| {
        if (sv.market_type) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceMarketOptions.MarketType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.spot_options) |sv2| {
            if (sv2.block_duration_minutes) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceMarketOptions.SpotOptions.BlockDurationMinutes=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
            if (sv2.instance_interruption_behavior) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceMarketOptions.SpotOptions.InstanceInterruptionBehavior=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv3));
            }
            if (sv2.max_price) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceMarketOptions.SpotOptions.MaxPrice=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
            if (sv2.spot_instance_type) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceMarketOptions.SpotOptions.SpotInstanceType=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv3));
            }
            if (sv2.valid_until) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceMarketOptions.SpotOptions.ValidUntil=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
        }
    }
    if (input.launch_template_data.instance_requirements) |sv| {
        if (sv.accelerator_count) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.AcceleratorCount.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.AcceleratorCount.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
        }
        if (sv.accelerator_manufacturers) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.AcceleratorManufacturers.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.accelerator_names) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.AcceleratorNames.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.accelerator_total_memory_mi_b) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
        }
        if (sv.accelerator_types) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.AcceleratorTypes.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.allowed_instance_types) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.AllowedInstanceTypes.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.bare_metal) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.BareMetal=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.baseline_ebs_bandwidth_mbps) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.BaselineEbsBandwidthMbps.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.BaselineEbsBandwidthMbps.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
        }
        if (sv.baseline_performance_factors) |sv2| {
            if (sv2.cpu) |sv3| {
                if (sv3.references) |list_d3| {
                    for (list_d3, 0..) |item, idx| {
                        const n = idx + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{n}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            if (item.instance_family) |fv_4| {
                                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_4);
                            }
                        }
                    }
                }
            }
        }
        if (sv.burstable_performance) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.BurstablePerformance=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.cpu_manufacturers) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.CpuManufacturers.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.excluded_instance_types) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.ExcludedInstanceTypes.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.instance_generations) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.InstanceGenerations.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.local_storage) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.LocalStorage=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.local_storage_types) |list_d1| {
            for (list_d1, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.InstanceRequirements.LocalStorageTypes.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
        if (sv.max_spot_price_as_percentage_of_optimal_on_demand_price) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.memory_gi_b_per_v_cpu) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.MemoryGiBPerVCpu.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.MemoryGiBPerVCpu.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
        }
        if (sv.memory_mi_b.max) |sv3| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.MemoryMiB.Max=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
        }
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.MemoryMiB.Min=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv.memory_mi_b.min}) catch "");
        if (sv.network_bandwidth_gbps) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.NetworkBandwidthGbps.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.NetworkBandwidthGbps.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
        }
        if (sv.network_interface_count) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.NetworkInterfaceCount.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.NetworkInterfaceCount.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
            }
        }
        if (sv.on_demand_max_price_percentage_over_lowest_price) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.require_encryption_in_transit) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.RequireEncryptionInTransit=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.require_hibernate_support) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.RequireHibernateSupport=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.spot_max_price_percentage_over_lowest_price) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.total_local_storage_gb) |sv2| {
            if (sv2.max) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.TotalLocalStorageGB.Max=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
            if (sv2.min) |sv3| {
                try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.TotalLocalStorageGB.Min=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, sv3);
            }
        }
        if (sv.v_cpu_count.max) |sv3| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.VCpuCount.Max=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv3}) catch "");
        }
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceRequirements.VCpuCount.Min=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv.v_cpu_count.min}) catch "");
    }
    if (input.launch_template_data.instance_type) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.InstanceType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.launch_template_data.kernel_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.KernelId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.key_name) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.KeyName=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.license_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.LicenseSpecifications.item.{d}.LicenseConfigurationArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.license_configuration_arn) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.launch_template_data.maintenance_options) |sv| {
        if (sv.auto_recovery) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.MaintenanceOptions.AutoRecovery=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
    }
    if (input.launch_template_data.metadata_options) |sv| {
        if (sv.http_endpoint) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.MetadataOptions.HttpEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.http_protocol_ipv_6) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.MetadataOptions.HttpProtocolIpv6=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.http_put_response_hop_limit) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.MetadataOptions.HttpPutResponseHopLimit=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.http_tokens) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.MetadataOptions.HttpTokens=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
        if (sv.instance_metadata_tags) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.MetadataOptions.InstanceMetadataTags=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
    }
    if (input.launch_template_data.monitoring) |sv| {
        if (sv.enabled) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Monitoring.Enabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
    }
    if (input.launch_template_data.network_interfaces) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.AssociateCarrierIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.associate_carrier_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.AssociatePublicIpAddress=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.associate_public_ip_address) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            if (item.connection_tracking_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.ConnectionTrackingSpecification.TcpEstablishedTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.tcp_established_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.ConnectionTrackingSpecification.UdpStreamTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.udp_stream_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.ConnectionTrackingSpecification.UdpTimeout=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.udp_timeout) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_2}) catch "");
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.DeleteOnTermination=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.delete_on_termination) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Description=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.description) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.DeviceIndex=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_index) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.EnaQueueCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ena_queue_count) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.ena_srd_specification) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.EnaSrdSpecification.EnaSrdEnabled=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.ena_srd_enabled) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                    }
                }
                if (sv_1.ena_srd_udp_specification) |sv_2| {
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Groups.SecurityGroupId.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.InterfaceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.interface_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Ipv4PrefixCount=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Ipv4Prefixes.item.{d}.Ipv4Prefix=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_4_prefix) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Ipv6AddressCount=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Ipv6Addresses.InstanceIpv6Address.{d}.Ipv6Address=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_6_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Ipv6PrefixCount=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.Ipv6Prefixes.item.{d}.Ipv6Prefix=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.ipv_6_prefix) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.NetworkCardIndex=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.network_card_index) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.NetworkInterfaceId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.network_interface_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.PrimaryIpv6=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.primary_ipv_6) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_1) "true" else "false");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.PrivateIpAddress=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.PrivateIpAddresses.item.{d}.Primary=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.primary) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, if (fv_2) "true" else "false");
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.PrivateIpAddresses.item.{d}.PrivateIpAddress=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.private_ip_address) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.SecondaryPrivateIpAddressCount=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.secondary_private_ip_address_count) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.NetworkInterfaces.InstanceNetworkInterfaceSpecification.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.subnet_id) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.launch_template_data.network_performance_options) |sv| {
        if (sv.bandwidth_weighting) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.NetworkPerformanceOptions.BandwidthWeighting=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
    }
    if (input.launch_template_data.operator) |sv| {
        if (sv.principal) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Operator.Principal=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    if (input.launch_template_data.placement) |sv| {
        if (sv.affinity) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.Affinity=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.availability_zone) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.AvailabilityZone=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.availability_zone_id) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.AvailabilityZoneId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.group_id) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.GroupId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.group_name) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.GroupName=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.host_id) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.HostId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.host_resource_group_arn) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.HostResourceGroupArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.partition_number) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.PartitionNumber=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.spread_domain) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.SpreadDomain=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.tenancy) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.Placement.Tenancy=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
    }
    if (input.launch_template_data.private_dns_name_options) |sv| {
        if (sv.enable_resource_name_dns_aaaa_record) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.PrivateDnsNameOptions.EnableResourceNameDnsAAAARecord=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.enable_resource_name_dns_a_record) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.PrivateDnsNameOptions.EnableResourceNameDnsARecord=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.hostname_type) |sv2| {
            try body_buf.appendSlice(alloc, "&LaunchTemplateData.PrivateDnsNameOptions.HostnameType=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv2));
        }
    }
    if (input.launch_template_data.ram_disk_id) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.RamDiskId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.launch_template_data.security_group_ids) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.SecurityGroupIds.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.launch_template_data.security_groups) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.SecurityGroups.SecurityGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.launch_template_data.tag_specifications) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.TagSpecifications.LaunchTemplateTagSpecificationRequest.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.TagSpecifications.LaunchTemplateTagSpecificationRequest.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LaunchTemplateData.TagSpecifications.LaunchTemplateTagSpecificationRequest.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.launch_template_data.user_data) |sv| {
        try body_buf.appendSlice(alloc, "&LaunchTemplateData.UserData=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&LaunchTemplateName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.launch_template_name);
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(alloc, "&Operator.Principal=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.version_description) |v| {
        try body_buf.appendSlice(alloc, "&VersionDescription=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateLaunchTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateLaunchTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "launchTemplate")) {
                    result.launch_template = try serde.deserializeLaunchTemplate(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "warning")) {
                    result.warning = try serde.deserializeValidationWarning(&reader, alloc);
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
