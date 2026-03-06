const std = @import("std");
const aws = @import("aws");
const ec2 = @import("ec2");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: ec2.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

var shared_vpc_id_buf: [64]u8 = undefined;
var shared_vpc_id: []const u8 = "";
var shared_sg_id_buf: [64]u8 = undefined;
var shared_sg_id: []const u8 = "";
var shared_eip_alloc_id_buf: [64]u8 = undefined;
var shared_eip_alloc_id: []const u8 = "";
var shared_volume_id_buf: [64]u8 = undefined;
var shared_volume_id: []const u8 = "";
var shared_instance_id_buf: [64]u8 = undefined;
var shared_instance_id: []const u8 = "";
var shared_az_buf: [64]u8 = undefined;
var shared_az: []const u8 = "";

const test_tags = [_]ec2.types.Tag{
    .{ .key = "aws-sdk-zig-test", .value = "true" },
    .{ .key = "created-by", .value = "integration-test" },
};

fn tagResource(
    alloc: std.mem.Allocator,
    resource_id: []const u8,
) !void {
    _ = try shared_client.createTags(alloc, .{
        .resources = &.{resource_id},
        .tags = &test_tags,
    }, .{});
}

fn storeId(
    buf: []u8,
    id: []const u8,
) []const u8 {
    @memcpy(buf[0..id.len], id);
    return buf[0..id.len];
}

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = ec2.Client.init(allocator, &shared_cfg);

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const az_result = try shared_client.describeAvailabilityZones(
        alloc,
        .{},
        .{},
    );
    const zones = az_result.availability_zones orelse
        return error.NoAvailabilityZones;
    if (zones.len == 0) return error.NoAvailabilityZones;
    const zone_name = zones[0].zone_name orelse
        return error.MissingZoneName;
    shared_az = storeId(&shared_az_buf, zone_name);

    shared_init = true;
}

test "zest.afterAll" {
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    if (shared_instance_id.len > 0) {
        _ = shared_client.terminateInstances(alloc, .{
            .instance_ids = &.{shared_instance_id},
        }, .{}) catch {};

        var attempts: u32 = 0;
        while (attempts < 24) : (attempts += 1) {
            std.time.sleep(5 * std.time.ns_per_s);
            const desc = shared_client.describeInstances(
                alloc,
                .{ .instance_ids = &.{shared_instance_id} },
                .{},
            ) catch break;
            const reservations = desc.reservations orelse
                break;
            if (reservations.len == 0) break;
            const instances = reservations[0].instances orelse
                break;
            if (instances.len == 0) break;
            const state = instances[0].state orelse break;
            const name = state.name orelse break;
            if (name == .terminated) break;
        }
    }

    if (shared_eip_alloc_id.len > 0) {
        _ = shared_client.releaseAddress(alloc, .{
            .allocation_id = shared_eip_alloc_id,
        }, .{}) catch {};
    }

    if (shared_volume_id.len > 0) {
        _ = shared_client.deleteVolume(alloc, .{
            .volume_id = shared_volume_id,
        }, .{}) catch {};
    }

    if (shared_sg_id.len > 0) {
        _ = shared_client.deleteSecurityGroup(alloc, .{
            .group_id = shared_sg_id,
        }, .{}) catch {};
    }

    if (shared_vpc_id.len > 0) {
        _ = shared_client.deleteVpc(alloc, .{
            .vpc_id = shared_vpc_id,
        }, .{}) catch {};
    }

    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "createVpc and describeVpcs" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const result = try shared_client.createVpc(
        alloc,
        .{ .cidr_block = "10.99.0.0/16" },
        .{},
    );
    const vpc_id = result.vpc.?.vpc_id orelse
        return error.MissingVpcId;
    shared_vpc_id = storeId(&shared_vpc_id_buf, vpc_id);

    try tagResource(alloc, shared_vpc_id);

    const desc = try shared_client.describeVpcs(
        alloc,
        .{ .filters = &.{.{
            .name = "vpc-id",
            .values = &.{shared_vpc_id},
        }} },
        .{},
    );
    const vpcs = desc.vpcs orelse return error.MissingVpcs;
    try std.testing.expect(vpcs.len >= 1);
    const cidr = vpcs[0].cidr_block orelse
        return error.MissingCidr;
    try std.testing.expectEqualStrings(
        "10.99.0.0/16",
        cidr,
    );
}

test "createSecurityGroup and describeSecurityGroups" {
    try std.testing.expect(shared_vpc_id.len > 0);

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const result = try shared_client.createSecurityGroup(
        alloc,
        .{
            .group_name = "sdk-zig-live-ec2-sg",
            .description = "sdk-zig live EC2 test SG",
            .vpc_id = shared_vpc_id,
        },
        .{},
    );
    const sg_id = result.group_id orelse
        return error.MissingGroupId;
    shared_sg_id = storeId(&shared_sg_id_buf, sg_id);

    try tagResource(alloc, shared_sg_id);

    const desc = try shared_client.describeSecurityGroups(
        alloc,
        .{ .filters = &.{.{
            .name = "group-id",
            .values = &.{shared_sg_id},
        }} },
        .{},
    );
    const groups = desc.security_groups orelse
        return error.MissingSGs;
    try std.testing.expect(groups.len >= 1);
    const name = groups[0].group_name orelse
        return error.MissingGroupName;
    try std.testing.expectEqualStrings(
        "sdk-zig-live-ec2-sg",
        name,
    );
}

test "authorizeSecurityGroupIngress adds rule" {
    try std.testing.expect(shared_sg_id.len > 0);

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    _ = try shared_client.authorizeSecurityGroupIngress(
        arena.allocator(),
        .{
            .group_id = shared_sg_id,
            .ip_permissions = &.{.{
                .ip_protocol = "tcp",
                .from_port = 22,
                .to_port = 22,
                .ip_ranges = &.{.{
                    .cidr_ip = "10.0.0.0/8",
                }},
            }},
        },
        .{},
    );
}

test "allocateAddress and describeAddresses" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const result = try shared_client.allocateAddress(
        alloc,
        .{ .domain = .vpc },
        .{},
    );
    const alloc_id = result.allocation_id orelse
        return error.MissingAllocationId;
    shared_eip_alloc_id = storeId(
        &shared_eip_alloc_id_buf,
        alloc_id,
    );

    try tagResource(alloc, shared_eip_alloc_id);

    const desc = try shared_client.describeAddresses(
        alloc,
        .{ .allocation_ids = &.{shared_eip_alloc_id} },
        .{},
    );
    const addrs = desc.addresses orelse
        return error.MissingAddresses;
    try std.testing.expect(addrs.len >= 1);
    try std.testing.expect(addrs[0].public_ip != null);
}

test "createVolume and describeVolumes" {
    try std.testing.expect(shared_az.len > 0);

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const result = try shared_client.createVolume(
        alloc,
        .{
            .availability_zone = shared_az,
            .size = 1,
            .volume_type = .gp3,
        },
        .{},
    );
    const vol_id = result.volume_id orelse
        return error.MissingVolumeId;
    shared_volume_id = storeId(
        &shared_volume_id_buf,
        vol_id,
    );

    try tagResource(alloc, shared_volume_id);

    const desc = try shared_client.describeVolumes(
        alloc,
        .{ .volume_ids = &.{shared_volume_id} },
        .{},
    );
    const vols = desc.volumes orelse
        return error.MissingVolumes;
    try std.testing.expect(vols.len >= 1);
    try std.testing.expectEqual(
        @as(?i32, 1),
        vols[0].size,
    );
}

test "runInstances launches a t3.nano" {
    try std.testing.expect(shared_sg_id.len > 0);
    try std.testing.expect(shared_vpc_id.len > 0);

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const images = try shared_client.describeImages(
        alloc,
        .{
            .filters = &.{
                .{
                    .name = "name",
                    .values = &.{
                        "al2023-ami-*-kernel-*-x86_64",
                    },
                },
                .{
                    .name = "owner-alias",
                    .values = &.{"amazon"},
                },
                .{
                    .name = "state",
                    .values = &.{"available"},
                },
            },
        },
        .{},
    );
    const ami_list = images.images orelse
        return error.NoAMIsFound;
    if (ami_list.len == 0) return error.NoAMIsFound;

    var best_idx: usize = 0;
    for (ami_list, 0..) |img, i| {
        if (i == 0) continue;
        const cur = img.creation_date orelse continue;
        const best = ami_list[best_idx].creation_date orelse
            continue;
        if (std.mem.order(u8, cur, best) == .gt) {
            best_idx = i;
        }
    }
    const ami_id = ami_list[best_idx].image_id orelse
        return error.MissingAmiId;

    const desc_subnets = try shared_client.describeSubnets(
        alloc,
        .{ .filters = &.{.{
            .name = "vpc-id",
            .values = &.{shared_vpc_id},
        }} },
        .{},
    );
    const subnets = desc_subnets.subnets orelse
        return error.MissingSubnets;
    if (subnets.len == 0) return error.MissingSubnets;
    const subnet_id = subnets[0].subnet_id orelse
        return error.MissingSubnetId;

    const run_result = try shared_client.runInstances(
        alloc,
        .{
            .image_id = ami_id,
            .instance_type = .t3_nano,
            .min_count = 1,
            .max_count = 1,
            .security_group_ids = &.{shared_sg_id},
            .subnet_id = subnet_id,
            .tag_specifications = &.{.{
                .resource_type = .instance,
                .tags = &test_tags,
            }},
        },
        .{},
    );

    const instances = run_result.instances orelse
        return error.MissingInstances;
    if (instances.len == 0) return error.MissingInstances;
    const inst_id = instances[0].instance_id orelse
        return error.MissingInstanceId;
    shared_instance_id = storeId(
        &shared_instance_id_buf,
        inst_id,
    );
}

test "describeInstances returns launched instance" {
    try std.testing.expect(shared_instance_id.len > 0);

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const result = try shared_client.describeInstances(
        arena.allocator(),
        .{ .instance_ids = &.{shared_instance_id} },
        .{},
    );
    const reservations = result.reservations orelse
        return error.MissingReservations;
    try std.testing.expect(reservations.len >= 1);
    const instances = reservations[0].instances orelse
        return error.MissingInstances;
    try std.testing.expect(instances.len >= 1);

    const state = instances[0].state orelse
        return error.MissingState;
    const name = state.name orelse
        return error.MissingStateName;
    try std.testing.expect(
        name == .pending or name == .running,
    );
}

test "describeRegions and describeAvailabilityZones" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    const regions = try shared_client.describeRegions(
        alloc,
        .{},
        .{},
    );
    const region_list = regions.regions orelse
        return error.MissingRegions;
    try std.testing.expect(region_list.len >= 1);

    const azs = try shared_client.describeAvailabilityZones(
        alloc,
        .{},
        .{},
    );
    const az_list = azs.availability_zones orelse
        return error.MissingAZs;
    try std.testing.expect(az_list.len >= 1);
}
