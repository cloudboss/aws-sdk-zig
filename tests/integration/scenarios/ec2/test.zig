const std = @import("std");
const aws = @import("aws");
const ec2 = @import("ec2");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ec2.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = ec2.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );
    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "DescribeVpcs returns results" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeVpcs(arena.allocator(), .{}, .{});

    const vpcs = result.vpcs orelse return error.MissingVpcs;
    try std.testing.expect(vpcs.len >= 1);
    try std.testing.expect(vpcs[0].vpc_id != null);
    try std.testing.expect(vpcs[0].cidr_block != null);
}

test "CreateVpc returns successfully" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.createVpc(
        arena.allocator(),
        .{ .cidr_block = "10.99.0.0/16" },
        .{},
    );
    const vpc_id = result.vpc.?.vpc_id orelse {
        return error.MissingVpcId;
    };

    _ = try shared_client.deleteVpc(
        arena.allocator(),
        .{ .vpc_id = vpc_id },
        .{},
    );
}

test "DescribeVpcs returns VPC with expected fields" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeVpcs(arena.allocator(), .{}, .{});

    const vpcs = result.vpcs orelse return error.MissingField;
    try std.testing.expect(vpcs.len >= 1);

    const vpc = vpcs[0];
    _ = vpc.vpc_id orelse return error.MissingField;
    _ = vpc.cidr_block orelse return error.MissingField;
    if (vpc.state == null) return error.MissingField;
}

test "CreateSecurityGroup returns group ID" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const vpcs_result = try shared_client.describeVpcs(arena.allocator(), .{}, .{});
    const vpcs = vpcs_result.vpcs orelse return error.MissingVpcs;
    if (vpcs.len == 0) return error.NoVpcs;
    const vpc_id = vpcs[0].vpc_id orelse return error.MissingVpcId;

    const create_result = try shared_client.createSecurityGroup(
        arena.allocator(),
        .{
            .group_name = "sdk-zig-ec2-sg",
            .description = "sdk-zig-ec2-security-group",
            .vpc_id = vpc_id,
        },
        .{},
    );

    const group_id = create_result.group_id orelse {
        return error.MissingGroupId;
    };

    _ = try shared_client.deleteSecurityGroup(
        arena.allocator(),
        .{ .group_id = group_id },
        .{},
    );
}

test "DescribeAvailabilityZones returns zones" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeAvailabilityZones(
        arena.allocator(),
        .{},
        .{},
    );

    const zones = result.availability_zones orelse return error.MissingField;
    try std.testing.expect(zones.len >= 1);
}

test "DescribeInstances returns successfully" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeInstances(
        arena.allocator(),
        .{},
        .{},
    );

    _ = result.reservations orelse return error.MissingField;
}

test "DescribeSubnets returns subnets in default VPC" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeSubnets(
        arena.allocator(),
        .{},
        .{},
    );

    const subnets = result.subnets orelse return error.MissingField;
    try std.testing.expect(subnets.len >= 1);
}

test "DescribeSecurityGroups returns default group" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeSecurityGroups(
        arena.allocator(),
        .{},
        .{},
    );

    const groups = result.security_groups orelse return error.MissingField;
    try std.testing.expect(groups.len >= 1);
}

test "DescribeSecurityGroups with filter returns matching group" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const vpcs_result = try shared_client.describeVpcs(arena.allocator(), .{}, .{});
    const vpcs = vpcs_result.vpcs orelse return error.MissingVpcs;
    if (vpcs.len == 0) return error.NoVpcs;
    const vpc_id = vpcs[0].vpc_id orelse return error.MissingVpcId;

    const create_result = try shared_client.createSecurityGroup(
        arena.allocator(),
        .{
            .group_name = "sdk-zig-ec2-filter-sg",
            .description = "sdk-zig-ec2-filter-security-group",
            .vpc_id = vpc_id,
        },
        .{},
    );
    const group_id = create_result.group_id orelse {
        return error.MissingGroupId;
    };

    const describe_result = try shared_client.describeSecurityGroups(
        arena.allocator(),
        .{
            .filters = &.{.{
                .name = "group-name",
                .values = &.{"sdk-zig-ec2-filter-sg"},
            }},
        },
        .{},
    );

    const groups = describe_result.security_groups orelse {
        _ = try shared_client.deleteSecurityGroup(
            arena.allocator(),
            .{ .group_id = group_id },
            .{},
        );
        return error.MissingField;
    };
    try std.testing.expect(groups.len >= 1);

    _ = try shared_client.deleteSecurityGroup(
        arena.allocator(),
        .{ .group_id = group_id },
        .{},
    );
}

test "AllocateAddress returns allocation ID" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.allocateAddress(
        arena.allocator(),
        .{ .domain = .vpc },
        .{},
    );
    const allocation_id = result.allocation_id orelse {
        return error.MissingAllocationId;
    };

    _ = try shared_client.releaseAddress(
        arena.allocator(),
        .{ .allocation_id = allocation_id },
        .{},
    );
}

test "DescribeVolumes with explicit Filter type" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const filters = [_]ec2.types.Filter{.{
        .name = "status",
        .values = &.{"available"},
    }};
    const result = try shared_client.describeVolumes(
        arena.allocator(),
        .{ .filters = &filters },
        .{},
    );

    // volumes field should be present (possibly empty list)
    _ = result.volumes orelse return error.MissingField;
}

test "DescribeVolumes filters by volume ID" {
    const allocator = std.testing.allocator;
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const vol_result = try shared_client.createVolume(
        alloc,
        .{ .availability_zone = "us-east-1a", .size = 1 },
        .{},
    );
    const volume_id = vol_result.volume_id orelse
        return error.MissingVolumeId;

    const by_id = try shared_client.describeVolumes(
        alloc,
        .{ .volume_ids = &.{volume_id} },
        .{},
    );
    const vols_by_id = by_id.volumes orelse {
        _ = shared_client.deleteVolume(
            alloc,
            .{ .volume_id = volume_id },
            .{},
        ) catch {};
        return error.MissingField;
    };
    try std.testing.expectEqualStrings(
        volume_id,
        vols_by_id[0].volume_id orelse
            return error.MissingField,
    );

    const by_filter = try shared_client.describeVolumes(
        alloc,
        .{ .filters = &.{.{
            .name = "volume-id",
            .values = &.{volume_id},
        }} },
        .{},
    );
    const vols_by_filter = by_filter.volumes orelse {
        _ = shared_client.deleteVolume(
            alloc,
            .{ .volume_id = volume_id },
            .{},
        ) catch {};
        return error.MissingField;
    };
    try std.testing.expectEqualStrings(
        volume_id,
        vols_by_filter[0].volume_id orelse
            return error.MissingField,
    );

    try std.testing.expectEqualStrings(
        vols_by_id[0].volume_id orelse
            return error.MissingField,
        vols_by_filter[0].volume_id orelse
            return error.MissingField,
    );

    _ = try shared_client.deleteVolume(
        alloc,
        .{ .volume_id = volume_id },
        .{},
    );
}

test "DescribeRegions returns AWS regions" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = try shared_client.describeRegions(
        arena.allocator(),
        .{},
        .{},
    );

    const regions = result.regions orelse return error.MissingField;
    try std.testing.expect(regions.len >= 1);
    try std.testing.expect(regions[0].region_name != null);
}
