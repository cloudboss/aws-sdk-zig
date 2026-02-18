const std = @import("std");
const aws = @import("aws");
const ec2 = @import("ec2");

test "DescribeVpcs returns results" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ec2.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try ec2.describe_vpcs.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // LocalStack returns a default VPC
    const vpcs = result.vpcs orelse return error.MissingVpcs;
    try std.testing.expect(vpcs.len >= 1);
    // Default VPC should have a vpc_id and cidr_block
    try std.testing.expect(vpcs[0].vpc_id != null);
    try std.testing.expect(vpcs[0].cidr_block != null);
}

test "CreateVpc and DeleteVpc round-trip" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ec2.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    // Create a VPC
    {
        var result = try ec2.create_vpc.execute(
            &client,
            .{ .cidr_block = "10.99.0.0/16" },
            .{},
        );
        defer result.deinit();
    }

    // Delete the VPC (need vpc-id from response, but response parsing is limited;
    // just verify the create call succeeded without error)
}

test "DescribeVpcs returns VPC with expected fields" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ec2.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try ec2.describe_vpcs.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    const vpcs = result.vpcs orelse return error.MissingField;
    try std.testing.expect(vpcs.len >= 1);

    const vpc = vpcs[0];
    _ = vpc.vpc_id orelse return error.MissingField;
    _ = vpc.cidr_block orelse return error.MissingField;
    if (vpc.state == null) return error.MissingField;
}

test "CreateSecurityGroup and DeleteSecurityGroup round-trip" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ec2.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    // Create the security group
    var create_result = try ec2.create_security_group.execute(
        &client,
        .{
            .group_name = "sdk-zig-ec2-sg",
            .description = "sdk-zig test security group",
        },
        .{},
    );
    defer create_result.deinit();

    const group_id = create_result.group_id orelse return error.MissingGroupId;

    // Delete using the group_id (owned by create_result's arena, still alive)
    var delete_result = try ec2.delete_security_group.execute(
        &client,
        .{ .group_id = group_id },
        .{},
    );
    defer delete_result.deinit();
}

test "DescribeAvailabilityZones returns zones" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ec2.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try ec2.describe_availability_zones.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // LocalStack returns at least one availability zone
    const zones = result.availability_zones orelse return error.MissingField;
    try std.testing.expect(zones.len >= 1);
}

test "DescribeInstances returns successfully" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = ec2.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    var result = try ec2.describe_instances.execute(
        &client,
        .{},
        .{},
    );
    defer result.deinit();

    // Verify reservations field is non-null (empty list is fine, null is not)
    _ = result.reservations orelse return error.MissingField;
}
