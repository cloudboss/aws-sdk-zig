const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const InstanceType = @import("instance_type.zig").InstanceType;
const InstanceTypeInfo = @import("instance_type_info.zig").InstanceTypeInfo;
const serde = @import("serde.zig");

pub const DescribeInstanceTypesInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters. Filter names and values are case-sensitive.
    ///
    /// * `auto-recovery-supported` - Indicates whether Amazon CloudWatch action
    /// based recovery is supported (`true` | `false`).
    ///
    /// * `bare-metal` - Indicates whether it is a bare metal instance type
    /// (`true` | `false`).
    ///
    /// * `burstable-performance-supported` - Indicates whether the instance type is
    ///   a
    /// burstable performance T instance type (`true` | `false`).
    ///
    /// * `current-generation` - Indicates whether this instance type is the latest
    /// generation instance type of an instance family (`true` | `false`).
    ///
    /// * `dedicated-hosts-supported` - Indicates whether the instance type supports
    /// Dedicated Hosts. (`true` | `false`)
    ///
    /// * `ebs-info.attachment-limit-type` - The type of Amazon EBS volume
    ///   attachment limit
    /// (`shared` | `dedicated`).
    ///
    /// * `ebs-info.maximum-ebs-attachments` - The maximum number of Amazon EBS
    ///   volumes that
    /// can be attached to the instance type.
    ///
    /// * `ebs-info.ebs-optimized-info.baseline-bandwidth-in-mbps` - The baseline
    /// bandwidth performance for an EBS-optimized instance type, in Mbps.
    ///
    /// * `ebs-info.ebs-optimized-info.baseline-iops` - The baseline input/output
    ///   storage
    /// operations per second for an EBS-optimized instance type.
    ///
    /// * `ebs-info.ebs-optimized-info.baseline-throughput-in-mbps` - The baseline
    /// throughput performance for an EBS-optimized instance type, in MB/s.
    ///
    /// * `ebs-info.ebs-optimized-info.maximum-bandwidth-in-mbps` - The maximum
    ///   bandwidth
    /// performance for an EBS-optimized instance type, in Mbps.
    ///
    /// * `ebs-info.ebs-optimized-info.maximum-iops` - The maximum input/output
    ///   storage
    /// operations per second for an EBS-optimized instance type.
    ///
    /// * `ebs-info.ebs-optimized-info.maximum-throughput-in-mbps` - The maximum
    /// throughput performance for an EBS-optimized instance type, in MB/s.
    ///
    /// * `ebs-info.ebs-optimized-support` - Indicates whether the instance type is
    /// EBS-optimized (`supported` | `unsupported` |
    /// `default`).
    ///
    /// * `ebs-info.encryption-support` - Indicates whether EBS encryption is
    ///   supported
    /// (`supported` | `unsupported`).
    ///
    /// * `ebs-info.nvme-support` - Indicates whether non-volatile memory express
    ///   (NVMe)
    /// is supported for EBS volumes (`required` | `supported` |
    /// `unsupported`).
    ///
    /// * `free-tier-eligible` - A Boolean that indicates whether this instance type
    ///   can
    /// be used under the Amazon Web Services Free Tier (`true` | `false`).
    ///
    /// * `hibernation-supported` - Indicates whether On-Demand hibernation is
    ///   supported
    /// (`true` | `false`).
    ///
    /// * `hypervisor` - The hypervisor (`nitro` | `xen`).
    ///
    /// * `instance-storage-info.disk.count` - The number of local disks.
    ///
    /// * `instance-storage-info.disk.size-in-gb` - The storage size of each
    ///   instance
    /// storage disk, in GB.
    ///
    /// * `instance-storage-info.disk.type` - The storage technology for the local
    /// instance storage disks (`hdd` | `ssd`).
    ///
    /// * `instance-storage-info.encryption-support` - Indicates whether data is
    /// encrypted at rest (`required` | `supported` |
    /// `unsupported`).
    ///
    /// * `instance-storage-info.nvme-support` - Indicates whether non-volatile
    ///   memory
    /// express (NVMe) is supported for instance store (`required` | `supported`
    /// | `unsupported`).
    ///
    /// * `instance-storage-info.total-size-in-gb` - The total amount of storage
    /// available from all local instance storage, in GB.
    ///
    /// * `instance-storage-supported` - Indicates whether the instance type has
    ///   local
    /// instance storage (`true` | `false`).
    ///
    /// * `instance-type` - The instance type (for example `c5.2xlarge` or
    /// c5*).
    ///
    /// * `memory-info.size-in-mib` - The memory size.
    ///
    /// * `network-info.bandwidth-weightings` - For instances that support bandwidth
    /// weighting to boost performance (`default`, `vpc-1`,
    /// `ebs-1`).
    ///
    /// * `network-info.efa-info.maximum-efa-interfaces` - The maximum number of
    ///   Elastic
    /// Fabric Adapters (EFAs) per instance.
    ///
    /// * `network-info.efa-supported` - Indicates whether the instance type
    ///   supports
    /// Elastic Fabric Adapter (EFA) (`true` | `false`).
    ///
    /// * `network-info.ena-support` - Indicates whether Elastic Network Adapter
    ///   (ENA) is
    /// supported or required (`required` | `supported` |
    /// `unsupported`).
    ///
    /// * `network-info.flexible-ena-queues-support` - Indicates whether an instance
    ///   supports
    /// flexible ENA queues (`supported` | `unsupported`).
    ///
    /// * `network-info.encryption-in-transit-supported` - Indicates whether the
    ///   instance
    /// type automatically encrypts in-transit traffic between instances (`true` |
    /// `false`).
    ///
    /// * `network-info.ipv4-addresses-per-interface` - The maximum number of
    ///   private
    /// IPv4 addresses per network interface.
    ///
    /// * `network-info.ipv6-addresses-per-interface` - The maximum number of
    ///   private
    /// IPv6 addresses per network interface.
    ///
    /// * `network-info.ipv6-supported` - Indicates whether the instance type
    ///   supports
    /// IPv6 (`true` | `false`).
    ///
    /// * `network-info.maximum-network-cards` - The maximum number of network cards
    ///   per
    /// instance.
    ///
    /// * `network-info.maximum-network-interfaces` - The maximum number of network
    /// interfaces per instance.
    ///
    /// * `network-info.network-performance` - The network performance (for example,
    ///   "25
    /// Gigabit").
    ///
    /// * `nitro-enclaves-support` - Indicates whether Nitro Enclaves is supported
    /// (`supported` | `unsupported`).
    ///
    /// * `nitro-tpm-support` - Indicates whether NitroTPM is supported
    /// (`supported` | `unsupported`).
    ///
    /// * `nitro-tpm-info.supported-versions` - The supported NitroTPM version
    /// (`2.0`).
    ///
    /// * `processor-info.supported-architecture` - The CPU architecture
    /// (`arm64` | `i386` | `x86_64`).
    ///
    /// * `processor-info.sustained-clock-speed-in-ghz` - The CPU clock speed, in
    /// GHz.
    ///
    /// * `processor-info.supported-features` - The supported CPU features
    /// (`amd-sev-snp`).
    ///
    /// * `reboot-migration-support` - Indicates whether enabling reboot migration
    ///   is
    /// supported (`supported` | `unsupported`).
    ///
    /// * `supported-boot-mode` - The boot mode (`legacy-bios` |
    /// `uefi`).
    ///
    /// * `supported-root-device-type` - The root device type (`ebs` |
    /// `instance-store`).
    ///
    /// * `supported-usage-class` - The usage class (`on-demand` |
    /// `spot` | `capacity-block`).
    ///
    /// * `supported-virtualization-type` - The virtualization type (`hvm` |
    /// `paravirtual`).
    ///
    /// * `vcpu-info.default-cores` - The default number of cores for the instance
    /// type.
    ///
    /// * `vcpu-info.default-threads-per-core` - The default number of threads per
    ///   core
    /// for the instance type.
    ///
    /// * `vcpu-info.default-vcpus` - The default number of vCPUs for the instance
    /// type.
    ///
    /// * `vcpu-info.valid-cores` - The number of cores that can be configured for
    ///   the
    /// instance type.
    ///
    /// * `vcpu-info.valid-threads-per-core` - The number of threads per core that
    ///   can be
    /// configured for the instance type. For example, "1" or "1,2".
    filters: ?[]const Filter = null,

    /// The instance types.
    instance_types: ?[]const InstanceType = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,
};

pub const DescribeInstanceTypesOutput = struct {
    /// The instance type.
    instance_types: ?[]const InstanceTypeInfo = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstanceTypesInput, options: CallOptions) !DescribeInstanceTypesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstanceTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeInstanceTypes&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.{d}.Value.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstanceTypesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeInstanceTypesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceTypeSet")) {
                    result.instance_types = try serde.deserializeInstanceTypeInfoList(allocator, &reader, "item");
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
