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
    var result = try ec2.describe_vpcs.execute(&shared_client, .{}, .{});
    defer result.deinit();

    const vpcs = result.vpcs orelse return error.MissingVpcs;
    try std.testing.expect(vpcs.len >= 1);
    try std.testing.expect(vpcs[0].vpc_id != null);
    try std.testing.expect(vpcs[0].cidr_block != null);
}

test "CreateVpc returns successfully" {
    var result = try ec2.create_vpc.execute(
        &shared_client,
        .{ .cidr_block = "10.99.0.0/16" },
        .{},
    );
    const vpc_id = result.vpc.?.vpc_id orelse {
        result.deinit();
        return error.MissingVpcId;
    };

    var delete_result = try ec2.delete_vpc.execute(
        &shared_client,
        .{ .vpc_id = vpc_id },
        .{},
    );
    delete_result.deinit();
    result.deinit();
}

test "DescribeVpcs returns VPC with expected fields" {
    var result = try ec2.describe_vpcs.execute(&shared_client, .{}, .{});
    defer result.deinit();

    const vpcs = result.vpcs orelse return error.MissingField;
    try std.testing.expect(vpcs.len >= 1);

    const vpc = vpcs[0];
    _ = vpc.vpc_id orelse return error.MissingField;
    _ = vpc.cidr_block orelse return error.MissingField;
    if (vpc.state == null) return error.MissingField;
}

test "CreateSecurityGroup returns group ID" {
    var vpcs_result = try ec2.describe_vpcs.execute(&shared_client, .{}, .{});
    defer vpcs_result.deinit();
    const vpcs = vpcs_result.vpcs orelse return error.MissingVpcs;
    if (vpcs.len == 0) return error.NoVpcs;
    const vpc_id = vpcs[0].vpc_id orelse return error.MissingVpcId;

    var create_result = try ec2.create_security_group.execute(
        &shared_client,
        .{
            .group_name = "sdk-zig-ec2-sg",
            .description = "sdk-zig-ec2-security-group",
            .vpc_id = vpc_id,
        },
        .{},
    );

    const group_id = create_result.group_id orelse {
        create_result.deinit();
        return error.MissingGroupId;
    };

    var delete_result = try ec2.delete_security_group.execute(
        &shared_client,
        .{ .group_id = group_id },
        .{},
    );
    delete_result.deinit();
    create_result.deinit();
}

test "DescribeAvailabilityZones returns zones" {
    var result = try ec2.describe_availability_zones.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const zones = result.availability_zones orelse return error.MissingField;
    try std.testing.expect(zones.len >= 1);
}

test "DescribeInstances returns successfully" {
    var result = try ec2.describe_instances.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    _ = result.reservations orelse return error.MissingField;
}

test "DescribeSubnets returns subnets in default VPC" {
    var result = try ec2.describe_subnets.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const subnets = result.subnets orelse return error.MissingField;
    try std.testing.expect(subnets.len >= 1);
}

test "DescribeSecurityGroups returns default group" {
    var result = try ec2.describe_security_groups.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const groups = result.security_groups orelse return error.MissingField;
    try std.testing.expect(groups.len >= 1);
}

test "DescribeSecurityGroups with filter returns matching group" {
    var vpcs_result = try ec2.describe_vpcs.execute(&shared_client, .{}, .{});
    defer vpcs_result.deinit();
    const vpcs = vpcs_result.vpcs orelse return error.MissingVpcs;
    if (vpcs.len == 0) return error.NoVpcs;
    const vpc_id = vpcs[0].vpc_id orelse return error.MissingVpcId;

    var create_result = try ec2.create_security_group.execute(
        &shared_client,
        .{
            .group_name = "sdk-zig-ec2-filter-sg",
            .description = "sdk-zig-ec2-filter-security-group",
            .vpc_id = vpc_id,
        },
        .{},
    );
    const group_id = create_result.group_id orelse {
        create_result.deinit();
        return error.MissingGroupId;
    };

    var describe_result = try ec2.describe_security_groups.execute(
        &shared_client,
        .{
            .filters = &.{.{
                .name = "group-name",
                .values = &.{"sdk-zig-ec2-filter-sg"},
            }},
        },
        .{},
    );
    defer describe_result.deinit();

    const groups = describe_result.security_groups orelse {
        var del = try ec2.delete_security_group.execute(
            &shared_client,
            .{ .group_id = group_id },
            .{},
        );
        del.deinit();
        create_result.deinit();
        return error.MissingField;
    };
    try std.testing.expect(groups.len >= 1);

    var delete_result = try ec2.delete_security_group.execute(
        &shared_client,
        .{ .group_id = group_id },
        .{},
    );
    delete_result.deinit();
    create_result.deinit();
}

test "AllocateAddress returns allocation ID" {
    var result = try ec2.allocate_address.execute(
        &shared_client,
        .{ .domain = .vpc },
        .{},
    );
    const allocation_id = result.allocation_id orelse {
        result.deinit();
        return error.MissingAllocationId;
    };

    var release_result = try ec2.release_address.execute(
        &shared_client,
        .{ .allocation_id = allocation_id },
        .{},
    );
    release_result.deinit();
    result.deinit();
}

test "DescribeRegions returns AWS regions" {
    var result = try ec2.describe_regions.execute(
        &shared_client,
        .{},
        .{},
    );
    defer result.deinit();

    const regions = result.regions orelse return error.MissingField;
    try std.testing.expect(regions.len >= 1);
    try std.testing.expect(regions[0].region_name != null);
}
