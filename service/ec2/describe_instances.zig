const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const Reservation = @import("reservation.zig").Reservation;

/// Describes the specified instances or all instances.
///
/// If you specify instance IDs, the output includes information for only the
/// specified
/// instances. If you specify filters, the output includes information for only
/// those
/// instances that meet the filter criteria. If you do not specify instance IDs
/// or filters,
/// the output includes information for all instances, which can affect
/// performance. We
/// recommend that you use pagination to ensure that the operation returns
/// quickly and
/// successfully.
///
/// The response includes SQL license exemption status information for instances
/// registered
/// with the SQL LE service, providing visibility into license exemption
/// configuration and status.
///
/// If you specify an instance ID that is not valid, an error is returned. If
/// you specify
/// an instance that you do not own, it is not included in the output.
///
/// Recently terminated instances might appear in the returned results. This
/// interval is
/// usually less than one hour.
///
/// If you describe instances in the rare case where an Availability Zone is
/// experiencing
/// a service disruption and you specify instance IDs that are in the affected
/// zone, or do
/// not specify any instance IDs at all, the call fails. If you describe
/// instances and
/// specify only instance IDs that are in an unaffected zone, the call works
/// normally.
///
/// The Amazon EC2 API follows an eventual consistency model. This means that
/// the result of an
/// API command you run that creates or modifies resources might not be
/// immediately
/// available to all subsequent commands you run. For guidance on how to manage
/// eventual
/// consistency, see [Eventual consistency in the
/// Amazon EC2
/// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
/// Guide*.
///
/// **Important:**
///
/// We strongly recommend using only paginated requests. Unpaginated requests
/// are
/// susceptible to throttling and timeouts.
///
/// **Note:**
///
/// The order of the elements in the response, including those within nested
/// structures, might vary. Applications should not assume the elements appear
/// in a
/// particular order.
pub const DescribeInstancesInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `affinity` - The affinity setting for an instance running on a
    /// Dedicated Host (`default` | `host`).
    ///
    /// * `architecture` - The instance architecture (`i386` |
    /// `x86_64` | `arm64`).
    ///
    /// * `availability-zone` - The Availability Zone of the instance.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone of the
    /// instance.
    ///
    /// * `block-device-mapping.attach-time` - The attach time for an EBS
    /// volume mapped to the instance, for example,
    /// `2022-09-15T17:15:20.000Z`.
    ///
    /// * `block-device-mapping.delete-on-termination` - A Boolean that
    /// indicates whether the EBS volume is deleted on instance termination.
    ///
    /// * `block-device-mapping.device-name` - The device name specified in
    /// the block device mapping (for example, `/dev/sdh` or
    /// `xvdh`).
    ///
    /// * `block-device-mapping.status` - The status for the EBS volume
    /// (`attaching` | `attached` | `detaching` |
    /// `detached`).
    ///
    /// * `block-device-mapping.volume-id` - The volume ID of the EBS
    /// volume.
    ///
    /// * `boot-mode` - The boot mode that was specified by the AMI
    /// (`legacy-bios` | `uefi` |
    /// `uefi-preferred`).
    ///
    /// * `capacity-reservation-id` - The ID of the Capacity Reservation into which
    ///   the
    /// instance was launched.
    ///
    /// * `capacity-reservation-specification.capacity-reservation-preference`
    /// - The instance's Capacity Reservation preference (`open` | `none`).
    ///
    /// *
    ///   `capacity-reservation-specification.capacity-reservation-target.capacity-reservation-id`
    /// - The ID of the targeted Capacity Reservation.
    ///
    /// *
    ///   `capacity-reservation-specification.capacity-reservation-target.capacity-reservation-resource-group-arn`
    /// - The ARN of the targeted Capacity Reservation group.
    ///
    /// * `client-token` - The idempotency token you provided when you
    /// launched the instance.
    ///
    /// * `current-instance-boot-mode` - The boot mode that is used to launch
    /// the instance at launch or start (`legacy-bios` |
    /// `uefi`).
    ///
    /// * `dns-name` - The public DNS name of the instance.
    ///
    /// * `ebs-optimized` - A Boolean that indicates whether the instance is
    /// optimized for Amazon EBS I/O.
    ///
    /// * `ena-support` - A Boolean that indicates whether the instance is
    /// enabled for enhanced networking with ENA.
    ///
    /// * `enclave-options.enabled` - A Boolean that indicates whether the
    /// instance is enabled for Amazon Web Services Nitro Enclaves.
    ///
    /// * `hibernation-options.configured` - A Boolean that indicates whether
    /// the instance is enabled for hibernation. A value of `true` means that
    /// the instance is enabled for hibernation.
    ///
    /// * `host-id` - The ID of the Dedicated Host on which the instance is
    /// running, if applicable.
    ///
    /// * `hypervisor` - The hypervisor type of the instance
    /// (`ovm` | `xen`). The value `xen` is used
    /// for both Xen and Nitro hypervisors.
    ///
    /// * `iam-instance-profile.arn` - The instance profile associated with
    /// the instance. Specified as an ARN.
    ///
    /// * `iam-instance-profile.id` - The instance profile associated with
    /// the instance. Specified as an ID.
    ///
    /// * `image-id` - The ID of the image used to launch the
    /// instance.
    ///
    /// * `instance-id` - The ID of the instance.
    ///
    /// * `instance-lifecycle` - Indicates whether this is a Spot Instance, a
    ///   Scheduled Instance, or
    /// a Capacity Block (`spot` | `scheduled` | `capacity-block`).
    ///
    /// * `instance-state-code` - The state of the instance, as a 16-bit
    /// unsigned integer. The high byte is used for internal purposes and should be
    /// ignored. The low byte is set based on the state represented. The valid
    /// values
    /// are: 0 (pending), 16 (running), 32 (shutting-down), 48 (terminated), 64
    /// (stopping), and 80 (stopped).
    ///
    /// * `instance-state-name` - The state of the instance
    /// (`pending` | `running` | `shutting-down` |
    /// `terminated` | `stopping` |
    /// `stopped`).
    ///
    /// * `instance-type` - The type of instance (for example,
    /// `t2.micro`).
    ///
    /// * `instance.group-id` - The ID of the security group for the
    /// instance.
    ///
    /// * `instance.group-name` - The name of the security group for the
    /// instance.
    ///
    /// * `ip-address` - The public IPv4 address of the instance.
    ///
    /// * `ipv6-address` - The IPv6 address of the instance.
    ///
    /// * `kernel-id` - The kernel ID.
    ///
    /// * `key-name` - The name of the key pair used when the instance was
    /// launched.
    ///
    /// * `launch-index` - When launching multiple instances, this is the
    /// index for the instance in the launch group (for example, 0, 1, 2, and so
    /// on).
    ///
    /// * `launch-time` - The time when the instance was launched, in the ISO
    /// 8601 format in the UTC time zone (YYYY-MM-DDThh:mm:ss.sssZ), for example,
    /// `2021-09-29T11:04:43.305Z`. You can use a wildcard
    /// (`*`), for example, `2021-09-29T*`, which matches an
    /// entire day.
    ///
    /// * `maintenance-options.auto-recovery` - The current automatic
    /// recovery behavior of the instance (`disabled` | `default`).
    ///
    /// * `metadata-options.http-endpoint` - The status of access to the HTTP
    /// metadata endpoint on your instance (`enabled` |
    /// `disabled`)
    ///
    /// * `metadata-options.http-protocol-ipv4` - Indicates whether the IPv4
    /// endpoint is enabled (`disabled` | `enabled`).
    ///
    /// * `metadata-options.http-protocol-ipv6` - Indicates whether the IPv6
    /// endpoint is enabled (`disabled` | `enabled`).
    ///
    /// * `metadata-options.http-put-response-hop-limit` - The HTTP metadata
    /// request put response hop limit (integer, possible values `1` to
    /// `64`)
    ///
    /// * `metadata-options.http-tokens` - The metadata request authorization
    /// state (`optional` | `required`)
    ///
    /// * `metadata-options.instance-metadata-tags` - The status of access to
    /// instance tags from the instance metadata (`enabled` |
    /// `disabled`)
    ///
    /// * `metadata-options.state` - The state of the metadata option changes
    /// (`pending` | `applied`).
    ///
    /// * `monitoring-state` - Indicates whether detailed monitoring is
    /// enabled (`disabled` | `enabled`).
    ///
    /// * `network-interface.addresses.association.allocation-id` - The allocation
    ///   ID.
    ///
    /// * `network-interface.addresses.association.association-id` - The association
    ///   ID.
    ///
    /// * `network-interface.addresses.association.carrier-ip` - The carrier IP
    ///   address.
    ///
    /// * `network-interface.addresses.association.customer-owned-ip` - The
    ///   customer-owned IP address.
    ///
    /// * `network-interface.addresses.association.ip-owner-id` - The owner
    /// ID of the private IPv4 address associated with the network interface.
    ///
    /// * `network-interface.addresses.association.public-dns-name` - The public DNS
    ///   name.
    ///
    /// * `network-interface.addresses.association.public-ip` - The ID of the
    /// association of an Elastic IP address (IPv4) with a network interface.
    ///
    /// * `network-interface.addresses.primary` - Specifies whether the IPv4
    /// address of the network interface is the primary private IPv4 address.
    ///
    /// * `network-interface.addresses.private-dns-name` - The private DNS name.
    ///
    /// * `network-interface.addresses.private-ip-address` - The private IPv4
    /// address associated with the network interface.
    ///
    /// * `network-interface.association.allocation-id` - The allocation ID
    /// returned when you allocated the Elastic IP address (IPv4) for your network
    /// interface.
    ///
    /// * `network-interface.association.association-id` - The association ID
    /// returned when the network interface was associated with an IPv4 address.
    ///
    /// * `network-interface.association.carrier-ip` - The customer-owned IP
    ///   address.
    ///
    /// * `network-interface.association.customer-owned-ip` - The customer-owned IP
    ///   address.
    ///
    /// * `network-interface.association.ip-owner-id` - The owner of the
    /// Elastic IP address (IPv4) associated with the network interface.
    ///
    /// * `network-interface.association.public-dns-name` - The public DNS name.
    ///
    /// * `network-interface.association.public-ip` - The address of the
    /// Elastic IP address (IPv4) bound to the network interface.
    ///
    /// * `network-interface.attachment.attach-time` - The time that the
    /// network interface was attached to an instance.
    ///
    /// * `network-interface.attachment.attachment-id` - The ID of the
    /// interface attachment.
    ///
    /// * `network-interface.attachment.delete-on-termination` - Specifies
    /// whether the attachment is deleted when an instance is terminated.
    ///
    /// * `network-interface.attachment.device-index` - The device index to
    /// which the network interface is attached.
    ///
    /// * `network-interface.attachment.instance-id` - The ID of the instance
    /// to which the network interface is attached.
    ///
    /// * `network-interface.attachment.instance-owner-id` - The owner ID of
    /// the instance to which the network interface is attached.
    ///
    /// * `network-interface.attachment.network-card-index` - The index of the
    ///   network card.
    ///
    /// * `network-interface.attachment.status` - The status of the
    /// attachment (`attaching` | `attached` |
    /// `detaching` | `detached`).
    ///
    /// * `network-interface.availability-zone` - The Availability Zone for
    /// the network interface.
    ///
    /// * `network-interface.deny-all-igw-traffic` - A Boolean that indicates
    ///   whether
    /// a network interface with an IPv6 address is unreachable from the public
    /// internet.
    ///
    /// * `network-interface.description` - The description of the network
    /// interface.
    ///
    /// * `network-interface.group-id` - The ID of a security group
    /// associated with the network interface.
    ///
    /// * `network-interface.group-name` - The name of a security group
    /// associated with the network interface.
    ///
    /// * `network-interface.ipv4-prefixes.ipv4-prefix` - The IPv4 prefixes that are
    ///   assigned to the network interface.
    ///
    /// * `network-interface.ipv6-address` - The IPv6 address associated with the
    ///   network interface.
    ///
    /// * `network-interface.ipv6-addresses.ipv6-address` - The IPv6 address
    /// associated with the network interface.
    ///
    /// * `network-interface.ipv6-addresses.is-primary-ipv6` - A Boolean that
    ///   indicates whether this
    /// is the primary IPv6 address.
    ///
    /// * `network-interface.ipv6-native` - A Boolean that indicates whether this is
    /// an IPv6 only network interface.
    ///
    /// * `network-interface.ipv6-prefixes.ipv6-prefix` - The IPv6 prefix assigned
    ///   to the network interface.
    ///
    /// * `network-interface.mac-address` - The MAC address of the network
    /// interface.
    ///
    /// * `network-interface.network-interface-id` - The ID of the network
    /// interface.
    ///
    /// * `network-interface.operator.managed` - A Boolean that indicates
    /// whether the instance has a managed network interface.
    ///
    /// * `network-interface.operator.principal` - The principal that manages
    /// the network interface. Only valid for instances with managed network
    /// interfaces,
    /// where `managed` is `true`.
    ///
    /// * `network-interface.outpost-arn` - The ARN of the Outpost.
    ///
    /// * `network-interface.owner-id` - The ID of the owner of the network
    /// interface.
    ///
    /// * `network-interface.private-dns-name` - The private DNS name of the
    /// network interface.
    ///
    /// * `network-interface.private-ip-address` - The private IPv4 address.
    ///
    /// * `network-interface.public-dns-name` - The public DNS name.
    ///
    /// * `network-interface.requester-id` - The requester ID for the network
    /// interface.
    ///
    /// * `network-interface.requester-managed` - Indicates whether the
    /// network interface is being managed by Amazon Web Services.
    ///
    /// * `network-interface.status` - The status of the network interface
    /// (`available`) | `in-use`).
    ///
    /// * `network-interface.source-dest-check` - Whether the network
    /// interface performs source/destination checking. A value of `true`
    /// means that checking is enabled, and `false` means that checking is
    /// disabled. The value must be `false` for the network interface to
    /// perform network address translation (NAT) in your VPC.
    ///
    /// * `network-interface.subnet-id` - The ID of the subnet for the
    /// network interface.
    ///
    /// * `network-interface.tag-key` - The key of a tag assigned to the network
    ///   interface.
    ///
    /// * `network-interface.tag-value` - The value of a tag assigned to the network
    ///   interface.
    ///
    /// * `network-interface.vpc-id` - The ID of the VPC for the network
    /// interface.
    ///
    /// * `network-performance-options.bandwidth-weighting` - Where the performance
    ///   boost
    /// is applied, if applicable. Valid values: `default`, `vpc-1`,
    /// `ebs-1`.
    ///
    /// * `operator.managed` - A Boolean that indicates whether this is a
    /// managed instance.
    ///
    /// * `operator.principal` - The principal that manages the instance.
    /// Only valid for managed instances, where `managed` is
    /// `true`.
    ///
    /// * `outpost-arn` - The Amazon Resource Name (ARN) of the
    /// Outpost.
    ///
    /// * `owner-id` - The Amazon Web Services account ID of the instance
    /// owner.
    ///
    /// * `placement-group-name` - The name of the placement group for the
    /// instance.
    ///
    /// * `placement-partition-number` - The partition in which the instance is
    /// located.
    ///
    /// * `platform` - The platform. To list only Windows instances, use
    /// `windows`.
    ///
    /// * `platform-details` - The platform (`Linux/UNIX` |
    /// `Red Hat BYOL Linux` | ` Red Hat Enterprise Linux` |
    /// `Red Hat Enterprise Linux with HA` | `Red Hat Enterprise Linux with High
    /// Availability` | `Red Hat Enterprise
    /// Linux with SQL Server Standard and HA` | `Red Hat Enterprise
    /// Linux with SQL Server Enterprise and HA` | `Red Hat Enterprise
    /// Linux with SQL Server Standard` | `Red Hat Enterprise Linux with
    /// SQL Server Web` | `Red Hat Enterprise Linux with SQL Server
    /// Enterprise` | `SQL Server Enterprise` | `SQL Server
    /// Standard` | `SQL Server Web` | `SUSE Linux` |
    /// `Ubuntu Pro` | `Windows` | `Windows BYOL` |
    /// `Windows with SQL Server Enterprise` | `Windows with SQL
    /// Server Standard` | `Windows with SQL Server Web`).
    ///
    /// * `private-dns-name` - The private IPv4 DNS name of the
    /// instance.
    ///
    /// * `private-dns-name-options.enable-resource-name-dns-a-record` - A
    /// Boolean that indicates whether to respond to DNS queries for instance
    /// hostnames
    /// with DNS A records.
    ///
    /// * `private-dns-name-options.enable-resource-name-dns-aaaa-record` - A
    /// Boolean that indicates whether to respond to DNS queries for instance
    /// hostnames
    /// with DNS AAAA records.
    ///
    /// * `private-dns-name-options.hostname-type` - The type of hostname
    /// (`ip-name` | `resource-name`).
    ///
    /// * `private-ip-address` - The private IPv4 address of the instance.
    /// This can only be used to filter by the primary IP address of the network
    /// interface attached to the instance. To filter by additional IP addresses
    /// assigned to the network interface, use the filter
    /// `network-interface.addresses.private-ip-address`.
    ///
    /// * `product-code` - The product code associated with the AMI used to
    /// launch the instance.
    ///
    /// * `product-code.type` - The type of product code (`devpay`
    /// | `marketplace`).
    ///
    /// * `ramdisk-id` - The RAM disk ID.
    ///
    /// * `reason` - The reason for the current state of the instance (for
    /// example, shows "User Initiated [date]" when you stop or terminate the
    /// instance).
    /// Similar to the state-reason-code filter.
    ///
    /// * `requester-id` - The ID of the entity that launched the instance on
    /// your behalf (for example, Amazon Web Services Management Console, Auto
    /// Scaling, and so
    /// on).
    ///
    /// * `reservation-id` - The ID of the instance's reservation. A
    /// reservation ID is created any time you launch an instance. A reservation ID
    /// has
    /// a one-to-one relationship with an instance launch request, but can be
    /// associated
    /// with more than one instance if you launch multiple instances using the same
    /// launch request. For example, if you launch one instance, you get one
    /// reservation
    /// ID. If you launch ten instances using the same launch request, you also get
    /// one
    /// reservation ID.
    ///
    /// * `root-device-name` - The device name of the root device volume (for
    /// example, `/dev/sda1`).
    ///
    /// * `root-device-type` - The type of the root device volume
    /// (`ebs` | `instance-store`).
    ///
    /// * `source-dest-check` - Indicates whether the instance performs
    /// source/destination checking. A value of `true` means that checking is
    /// enabled, and `false` means that checking is disabled. The value must
    /// be `false` for the instance to perform network address translation
    /// (NAT) in your VPC.
    ///
    /// * `spot-instance-request-id` - The ID of the Spot Instance
    /// request.
    ///
    /// * `state-reason-code` - The reason code for the state change.
    ///
    /// * `state-reason-message` - A message that describes the state
    /// change.
    ///
    /// * `subnet-id` - The ID of the subnet for the instance.
    ///
    /// * `tag:` - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources that have a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `tenancy` - The tenancy of an instance (`dedicated` |
    /// `default` | `host`).
    ///
    /// * `tpm-support` - Indicates if the instance is configured for
    /// NitroTPM support (`v2.0`).
    ///
    /// * `usage-operation` - The usage operation value for the instance
    /// (`RunInstances` | `RunInstances:00g0` |
    /// `RunInstances:0010` | `RunInstances:1010` |
    /// `RunInstances:1014` | `RunInstances:1110` |
    /// `RunInstances:0014` | `RunInstances:0210` |
    /// `RunInstances:0110` | `RunInstances:0100` |
    /// `RunInstances:0004` | `RunInstances:0200` |
    /// `RunInstances:000g` | `RunInstances:0g00` |
    /// `RunInstances:0002` | `RunInstances:0800` |
    /// `RunInstances:0102` | `RunInstances:0006` |
    /// `RunInstances:0202`).
    ///
    /// * `usage-operation-update-time` - The time that the usage operation
    /// was last updated, for example, `2022-09-15T17:15:20.000Z`.
    ///
    /// * `virtualization-type` - The virtualization type of the instance
    /// (`paravirtual` | `hvm`).
    ///
    /// * `vpc-id` - The ID of the VPC that the instance is running in.
    filters: ?[]const Filter = null,

    /// The instance IDs.
    ///
    /// Default: Describes all your instances.
    instance_ids: ?[]const []const u8 = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    ///
    /// You cannot specify this parameter and the instance IDs parameter in the same
    /// request.
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,
};

pub const DescribeInstancesOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,

    /// Information about the reservations.
    reservations: ?[]const Reservation = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeInstancesOutput) void {
        if (self.next_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeInstancesInput, options: Options) !DescribeInstancesOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeInstances&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.instance_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceIds.InstanceId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !DescribeInstancesOutput {
    _ = status;
    var result: DescribeInstancesOutput = .{ .allocator = alloc };
    if (findElement(body, "nextToken")) |content| {
        result.next_token = try alloc.dupe(u8, content);
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
