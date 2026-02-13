const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ArchitectureType = @import("architecture_type.zig").ArchitectureType;
const InstanceRequirementsRequest = @import("instance_requirements_request.zig").InstanceRequirementsRequest;
const VirtualizationType = @import("virtualization_type.zig").VirtualizationType;
const InstanceTypeInfoFromInstanceRequirements = @import("instance_type_info_from_instance_requirements.zig").InstanceTypeInfoFromInstanceRequirements;
const serde = @import("serde.zig");

/// Returns a list of instance types with the specified instance attributes. You
/// can
/// use the response to preview the instance types without launching instances.
/// Note
/// that the response does not consider capacity.
///
/// When you specify multiple parameters, you get instance types that satisfy
/// all of the
/// specified parameters. If you specify multiple values for a parameter, you
/// get instance
/// types that satisfy any of the specified values.
///
/// For more information, see [Preview instance types with specified
/// attributes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html#ec2fleet-get-instance-types-from-instance-requirements), [Specify attributes for instance type selection for EC2 Fleet or Spot Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html), and [Spot
/// placement
/// score](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-placement-score.html) in the *Amazon EC2 User Guide*, and [Creating
/// mixed instance groups using attribute-based instance type
/// selection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html) in the
/// *Amazon EC2 Auto Scaling User Guide*.
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetInstanceTypesFromInstanceRequirementsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetInstanceTypesFromInstanceRequirementsInput, options: Options) !GetInstanceTypesFromInstanceRequirementsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetInstanceTypesFromInstanceRequirementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetInstanceTypesFromInstanceRequirements&Version=2016-11-15");
    for (input.architecture_types, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ArchitectureTypes.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.context) |v| {
        try body_buf.appendSlice(alloc, "&Context=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_requirements.accelerator_count) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.AcceleratorCount.Max=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.AcceleratorCount.Min=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.accelerator_manufacturers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AcceleratorManufacturers.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.accelerator_names) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AcceleratorNames.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.accelerator_total_memory_mi_b) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.AcceleratorTotalMemoryMiB.Max=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.AcceleratorTotalMemoryMiB.Min=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.accelerator_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AcceleratorTypes.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.allowed_instance_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.AllowedInstanceTypes.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.bare_metal) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.BareMetal=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.instance_requirements.baseline_ebs_bandwidth_mbps) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.BaselineEbsBandwidthMbps.Max=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.BaselineEbsBandwidthMbps.Min=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.baseline_performance_factors) |sv| {
        if (sv.cpu) |sv2| {
            if (sv2.references) |list_d2| {
                for (list_d2, 0..) |item, idx| {
                    const n = idx + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.BaselinePerformanceFactors.Cpu.References.item.{d}.InstanceFamily=", .{n}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item.instance_family) |fv_3| {
                            try appendUrlEncoded(alloc, &body_buf, fv_3);
                        }
                    }
                }
            }
        }
    }
    if (input.instance_requirements.burstable_performance) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.BurstablePerformance=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.instance_requirements.cpu_manufacturers) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.CpuManufacturers.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.excluded_instance_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.ExcludedInstanceTypes.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.instance_generations) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.InstanceGenerations.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.local_storage) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.LocalStorage=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.instance_requirements.local_storage_types) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceRequirements.LocalStorageTypes.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.instance_requirements.max_spot_price_as_percentage_of_optimal_on_demand_price) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.MaxSpotPriceAsPercentageOfOptimalOnDemandPrice=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.instance_requirements.memory_gi_b_per_v_cpu) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.MemoryGiBPerVCpu.Max=");
            try appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.MemoryGiBPerVCpu.Min=");
            try appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    if (input.instance_requirements.memory_mi_b.max) |sv2| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.MemoryMiB.Max=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
    }
    try body_buf.appendSlice(alloc, "&InstanceRequirements.MemoryMiB.Min=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.instance_requirements.memory_mi_b.min}) catch "");
    if (input.instance_requirements.network_bandwidth_gbps) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.NetworkBandwidthGbps.Max=");
            try appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.NetworkBandwidthGbps.Min=");
            try appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    if (input.instance_requirements.network_interface_count) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.NetworkInterfaceCount.Max=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.NetworkInterfaceCount.Min=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
        }
    }
    if (input.instance_requirements.on_demand_max_price_percentage_over_lowest_price) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.OnDemandMaxPricePercentageOverLowestPrice=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.instance_requirements.require_encryption_in_transit) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.RequireEncryptionInTransit=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.instance_requirements.require_hibernate_support) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.RequireHibernateSupport=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.instance_requirements.spot_max_price_percentage_over_lowest_price) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.SpotMaxPricePercentageOverLowestPrice=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.instance_requirements.total_local_storage_gb) |sv| {
        if (sv.max) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.TotalLocalStorageGB.Max=");
            try appendUrlEncoded(alloc, &body_buf, sv2);
        }
        if (sv.min) |sv2| {
            try body_buf.appendSlice(alloc, "&InstanceRequirements.TotalLocalStorageGB.Min=");
            try appendUrlEncoded(alloc, &body_buf, sv2);
        }
    }
    if (input.instance_requirements.v_cpu_count.max) |sv2| {
        try body_buf.appendSlice(alloc, "&InstanceRequirements.VCpuCount.Max=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv2}) catch "");
    }
    try body_buf.appendSlice(alloc, "&InstanceRequirements.VCpuCount.Min=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.instance_requirements.v_cpu_count.min}) catch "");
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    for (input.virtualization_types, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VirtualizationTypes.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetInstanceTypesFromInstanceRequirementsOutput {
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
                    result.instance_types = try serde.deserializeInstanceTypeInfoFromInstanceRequirementsSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
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
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
