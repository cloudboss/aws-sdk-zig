const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceRequirementsWithMetadataRequest = @import("instance_requirements_with_metadata_request.zig").InstanceRequirementsWithMetadataRequest;
const TargetCapacityUnitType = @import("target_capacity_unit_type.zig").TargetCapacityUnitType;
const SpotPlacementScore = @import("spot_placement_score.zig").SpotPlacementScore;
const serde = @import("serde.zig");

pub const GetSpotPlacementScoresInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with those attributes.
    ///
    /// If you specify `InstanceRequirementsWithMetadata`, you can't specify
    /// `InstanceTypes`.
    instance_requirements_with_metadata: ?InstanceRequirementsWithMetadataRequest = null,

    /// The instance types. We recommend that you specify at least three instance
    /// types. If you
    /// specify one or two instance types, or specify variations of a single
    /// instance type (for
    /// example, an `m3.xlarge` with and without instance storage), the returned
    /// placement score will always be low.
    ///
    /// If you specify `InstanceTypes`, you can't specify
    /// `InstanceRequirementsWithMetadata`.
    instance_types: ?[]const []const u8 = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// The Regions used to narrow down the list of Regions to be scored. Enter the
    /// Region code,
    /// for example, `us-east-1`.
    region_names: ?[]const []const u8 = null,

    /// Specify `true` so that the response returns a list of scored Availability
    /// Zones.
    /// Otherwise, the response returns a list of scored Regions.
    ///
    /// A list of scored Availability Zones is useful if you want to launch all of
    /// your Spot
    /// capacity into a single Availability Zone.
    single_availability_zone: ?bool = null,

    /// The target capacity.
    target_capacity: i32,

    /// The unit for the target capacity.
    target_capacity_unit_type: ?TargetCapacityUnitType = null,
};

pub const GetSpotPlacementScoresOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,

    /// The Spot placement score for the top 10 Regions or Availability Zones,
    /// scored on a scale
    /// from 1 to 10. Each score  reflects how likely it is that each Region or
    /// Availability Zone
    /// will succeed at fulfilling the specified target capacity  *at the time of
    /// the Spot
    /// placement score request*. A score of `10` means that your Spot
    /// capacity request is highly likely to succeed in that Region or Availability
    /// Zone.
    ///
    /// If you request a Spot placement score for Regions, a high score assumes that
    /// your fleet
    /// request will be configured to use all Availability Zones and the
    /// `capacity-optimized` allocation strategy. If you request a Spot placement
    /// score for Availability Zones, a high score assumes that your fleet request
    /// will be
    /// configured to use a single Availability Zone and the `capacity-optimized`
    /// allocation strategy.
    ///
    /// Different  Regions or Availability Zones might return the same score.
    ///
    /// The Spot placement score serves as a recommendation only. No score
    /// guarantees that your
    /// Spot request will be fully or partially fulfilled.
    spot_placement_scores: ?[]const SpotPlacementScore = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSpotPlacementScoresInput, options: CallOptions) !GetSpotPlacementScoresOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSpotPlacementScoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetSpotPlacementScores&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_requirements_with_metadata) |v| {
        if (v.architecture_types) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.ArchitectureType.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
            }
        }
        if (v.instance_requirements) |sv| {
            if (sv.accelerator_count) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorCount.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorCount.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.accelerator_manufacturers) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorManufacturer.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
                }
            }
            if (sv.accelerator_names) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorName.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
                }
            }
            if (sv.accelerator_total_memory_mi_b) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorTotalMemoryMiB.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorTotalMemoryMiB.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.accelerator_types) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.AcceleratorType.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
                }
            }
            if (sv.allowed_instance_types) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.AllowedInstanceType.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item);
                }
            }
            if (sv.bare_metal) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.BareMetal=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
            }
            if (sv.baseline_ebs_bandwidth_mbps) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.BaselineEbsBandwidthMbps.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.BaselineEbsBandwidthMbps.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.baseline_performance_factors) |sv2| {
                if (sv2.cpu) |sv3| {
                    if (sv3.references) |list_d3| {
                        for (list_d3, 0..) |item, idx| {
                            const n = idx + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                if (item.instance_family) |fv_4| {
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.BaselinePerformanceFactors.Cpu.Reference.{d}.InstanceFamily=", .{n}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_4);
                                }
                            }
                        }
                    }
                }
            }
            if (sv.burstable_performance) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.BurstablePerformance=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
            }
            if (sv.cpu_manufacturers) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.CpuManufacturer.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
                }
            }
            if (sv.excluded_instance_types) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.ExcludedInstanceType.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item);
                }
            }
            if (sv.instance_generations) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.InstanceGeneration.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
                }
            }
            if (sv.local_storage) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.LocalStorage=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv2.wireName());
            }
            if (sv.local_storage_types) |list_d1| {
                for (list_d1, 0..) |item, idx| {
                    const n = idx + 1;
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.InstanceRequirements.LocalStorageType.{d}=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
                }
            }
            if (sv.max_spot_price_as_percentage_of_optimal_on_demand_price) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.memory_gi_b_per_v_cpu) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.MemoryGiBPerVCpu.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.MemoryGiBPerVCpu.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.memory_mi_b.max) |sv3| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.MemoryMiB.Max=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
            }
            try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.MemoryMiB.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv.memory_mi_b.min}) catch "");
            if (sv.network_bandwidth_gbps) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.NetworkBandwidthGbps.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.NetworkBandwidthGbps.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.network_interface_count) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.NetworkInterfaceCount.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.NetworkInterfaceCount.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.on_demand_max_price_percentage_over_lowest_price) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.require_encryption_in_transit) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.RequireEncryptionInTransit=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
            }
            if (sv.require_hibernate_support) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.RequireHibernateSupport=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
            }
            if (sv.spot_max_price_percentage_over_lowest_price) |sv2| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
            }
            if (sv.total_local_storage_gb) |sv2| {
                if (sv2.max) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.TotalLocalStorageGB.Max=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
                if (sv2.min) |sv3| {
                    try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.TotalLocalStorageGB.Min=");
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
                }
            }
            if (sv.v_cpu_count.max) |sv3| {
                try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.VCpuCount.Max=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv3}) catch "");
            }
            try body_buf.appendSlice(allocator, "&InstanceRequirementsWithMetadata.InstanceRequirements.VCpuCount.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv.v_cpu_count.min}) catch "");
        }
        if (v.virtualization_types) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirementsWithMetadata.VirtualizationType.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
            }
        }
    }
    if (input.instance_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceType.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.region_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RegionName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.single_availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&SingleAvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&TargetCapacity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.target_capacity}) catch "");
    if (input.target_capacity_unit_type) |v| {
        try body_buf.appendSlice(allocator, "&TargetCapacityUnitType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSpotPlacementScoresOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetSpotPlacementScoresOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "spotPlacementScoreSet")) {
                    result.spot_placement_scores = try serde.deserializeSpotPlacementScores(allocator, &reader, "item");
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
