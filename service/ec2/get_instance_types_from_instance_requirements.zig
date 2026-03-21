const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ArchitectureType = @import("architecture_type.zig").ArchitectureType;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const VirtualizationType = @import("virtualization_type.zig").VirtualizationType;
const InstanceTypeInfoFromInstanceRequirements = @import("instance_type_info_from_instance_requirements.zig").InstanceTypeInfoFromInstanceRequirements;
const serde = @import("serde.zig");

pub const GetInstanceTypesFromInstanceRequirementsInput = struct {
    /// The processor architecture type.
    architecture_types: []const ArchitectureType,

    /// Reserved.
    context: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The attributes required for the instance types.
    instance_requirements: InstanceRequirementsRequest,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// The virtualization type.
    virtualization_types: []const VirtualizationType,
};

pub const GetInstanceTypesFromInstanceRequirementsOutput = struct {
    /// The instance types with the specified instance attributes.
    instance_types: ?[]const InstanceTypeInfoFromInstanceRequirements = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstanceTypesFromInstanceRequirementsInput, options: CallOptions) !GetInstanceTypesFromInstanceRequirementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstanceTypesFromInstanceRequirementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetInstanceTypesFromInstanceRequirements&Version=2016-11-15");
    for (input.architecture_types, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ArchitectureType.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
    }
    if (input.context) |v| {
        try body_buf.appendSlice(allocator, "&Context=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_requirements.accelerator_count) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.AcceleratorCount.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.AcceleratorCount.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.accelerator_manufacturers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AcceleratorManufacturer.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.instance_requirements.accelerator_names) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AcceleratorName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.instance_requirements.accelerator_total_memory_mi_b) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.AcceleratorTotalMemoryMiB.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.AcceleratorTotalMemoryMiB.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.accelerator_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AcceleratorType.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.instance_requirements.allowed_instance_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AllowedInstanceType.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.instance_requirements.bare_metal) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.BareMetal=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.instance_requirements.baseline_ebs_bandwidth_mbps) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.BaselineEbsBandwidthMbps.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.BaselineEbsBandwidthMbps.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.baseline_performance_factors) |sv| {
        if (sv.cpu) |sv2| {
            if (sv2.references) |list_d2| {
                for (list_d2, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item.instance_family) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.BaselinePerformanceFactors.Cpu.Reference.{d}.InstanceFamily=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                }
            }
        }
    }
    if (input.instance_requirements.burstable_performance) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.BurstablePerformance=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.instance_requirements.cpu_manufacturers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.CpuManufacturer.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.instance_requirements.excluded_instance_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.ExcludedInstanceType.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.instance_requirements.instance_generations) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.InstanceGeneration.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.instance_requirements.local_storage) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.LocalStorage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
    }
    if (input.instance_requirements.local_storage_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.LocalStorageType.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
        }
    }
    if (input.instance_requirements.max_spot_price_as_percentage_of_optimal_on_demand_price) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.instance_requirements.memory_gi_b_per_v_cpu) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.MemoryGiBPerVCpu.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.MemoryGiBPerVCpu.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.memory_mi_b.max) |sv2| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.MemoryMiB.Max=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
    }
    try body_buf.appendSlice(allocator, "&InstanceRequirements.MemoryMiB.Min=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.instance_requirements.memory_mi_b.min}) catch "");
    if (input.instance_requirements.network_bandwidth_gbps) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.NetworkBandwidthGbps.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.NetworkBandwidthGbps.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.network_interface_count) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.NetworkInterfaceCount.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.NetworkInterfaceCount.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.on_demand_max_price_percentage_over_lowest_price) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.instance_requirements.require_encryption_in_transit) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.RequireEncryptionInTransit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.instance_requirements.require_hibernate_support) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.RequireHibernateSupport=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
    }
    if (input.instance_requirements.spot_max_price_percentage_over_lowest_price) |sv| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
    }
    if (input.instance_requirements.total_local_storage_gb) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.TotalLocalStorageGB.Max=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(allocator, "&InstanceRequirements.TotalLocalStorageGB.Min=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.v_cpu_count.max) |sv2| {
        try body_buf.appendSlice(allocator, "&InstanceRequirements.VCpuCount.Max=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
    }
    try body_buf.appendSlice(allocator, "&InstanceRequirements.VCpuCount.Min=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.instance_requirements.v_cpu_count.min}) catch "");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    for (input.virtualization_types, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VirtualizationType.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstanceTypesFromInstanceRequirementsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetInstanceTypesFromInstanceRequirementsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceTypeSet")) {
                    result.instance_types = try serde.deserializeInstanceTypeInfoFromInstanceRequirementsSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
