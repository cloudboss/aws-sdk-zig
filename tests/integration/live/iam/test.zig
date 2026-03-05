const std = @import("std");
const aws = @import("aws");
const iam = @import("iam");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: iam.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

var role_name_buf: [64]u8 = undefined;
var role_name: []const u8 = "";
var policy_arn_buf: [256]u8 = undefined;
var policy_arn: []const u8 = "";
var user_name_buf: [64]u8 = undefined;
var user_name: []const u8 = "";

const trust_policy =
    \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":"lambda.amazonaws.com"},"Action":"sts:AssumeRole"}]}
;
const deny_all_policy =
    \\{"Version":"2012-10-17","Statement":[{"Effect":"Deny","Action":"*","Resource":"*"}]}
;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = iam.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );

    role_name = try std.fmt.bufPrint(
        &role_name_buf,
        "sdk-zig-live-role-{d}",
        .{std.time.timestamp()},
    );

    _ = try shared_client.createRole(
        arena.allocator(),
        .{
            .role_name = role_name,
            .path = "/sdk-zig-live/",
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );

    _ = try shared_client.tagRole(
        arena.allocator(),
        .{
            .role_name = role_name,
            .tags = &.{
                .{
                    .key = "aws-sdk-zig-test",
                    .value = "true",
                },
                .{
                    .key = "created-by",
                    .value = "integration-test",
                },
            },
        },
        .{},
    );

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

    // Detach all policies from the role before deleting it.
    if (shared_client.listAttachedRolePolicies(
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    )) |list| {
        if (list.attached_policies) |policies| {
            for (policies) |p| {
                if (p.policy_arn) |arn| {
                    _ = shared_client.detachRolePolicy(
                        arena.allocator(),
                        .{
                            .role_name = role_name,
                            .policy_arn = arn,
                        },
                        .{},
                    ) catch {};
                }
            }
        }
    } else |_| {}

    _ = shared_client.deleteRole(
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    ) catch {};

    if (policy_arn.len > 0) {
        _ = shared_client.deletePolicy(
            arena.allocator(),
            .{ .policy_arn = policy_arn },
            .{},
        ) catch {};
    }

    if (user_name.len > 0) {
        _ = shared_client.deleteUser(
            arena.allocator(),
            .{ .user_name = user_name },
            .{},
        ) catch {};
    }

    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "getRole returns role metadata" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.getRole(
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );

    const role = result.role orelse return error.MissingRole;
    try std.testing.expectEqualStrings(role_name, role.role_name);
}

test "listRoles with path prefix returns created role" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.listRoles(
        arena.allocator(),
        .{ .path_prefix = "/sdk-zig-live/" },
        .{},
    );

    const roles = result.roles orelse return error.MissingRoles;
    var found = false;
    for (roles) |r| {
        if (std.mem.eql(u8, r.role_name, role_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);
}

test "createPolicy creates a policy" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var name_buf: [64]u8 = undefined;
    const pname = try std.fmt.bufPrint(
        &name_buf,
        "sdk-zig-live-policy-{d}",
        .{std.time.timestamp()},
    );

    const result = try shared_client.createPolicy(
        arena.allocator(),
        .{
            .policy_name = pname,
            .policy_document = deny_all_policy,
            .path = "/sdk-zig-live/",
        },
        .{},
    );

    const policy = result.policy orelse
        return error.MissingPolicy;
    const arn = policy.arn orelse
        return error.MissingPolicyArn;
    try std.testing.expect(arn.len > 0);

    @memcpy(policy_arn_buf[0..arn.len], arn);
    policy_arn = policy_arn_buf[0..arn.len];
}

test "attachRolePolicy attaches to role" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    try std.testing.expect(policy_arn.len > 0);

    _ = try shared_client.attachRolePolicy(
        arena.allocator(),
        .{
            .role_name = role_name,
            .policy_arn = policy_arn,
        },
        .{},
    );
}

test "listAttachedRolePolicies includes attached policy" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.listAttachedRolePolicies(
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );

    const policies = result.attached_policies orelse
        return error.MissingAttachedPolicies;
    var found = false;
    for (policies) |p| {
        if (p.policy_arn) |arn| {
            if (std.mem.eql(u8, arn, policy_arn)) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);
}

test "detachRolePolicy removes from role" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    _ = try shared_client.detachRolePolicy(
        arena.allocator(),
        .{
            .role_name = role_name,
            .policy_arn = policy_arn,
        },
        .{},
    );

    const result = try shared_client.listAttachedRolePolicies(
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );

    if (result.attached_policies) |policies| {
        for (policies) |p| {
            if (p.policy_arn) |arn| {
                if (std.mem.eql(u8, arn, policy_arn)) {
                    return error.PolicyStillAttached;
                }
            }
        }
    }
}

test "deletePolicy removes the policy" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    try std.testing.expect(policy_arn.len > 0);

    _ = try shared_client.deletePolicy(
        arena.allocator(),
        .{ .policy_arn = policy_arn },
        .{},
    );

    policy_arn = "";
}

test "createUser and deleteUser" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    user_name = try std.fmt.bufPrint(
        &user_name_buf,
        "sdk-zig-live-user-{d}",
        .{std.time.timestamp()},
    );

    const result = try shared_client.createUser(
        arena.allocator(),
        .{
            .user_name = user_name,
            .path = "/sdk-zig-live/",
        },
        .{},
    );

    const user = result.user orelse return error.MissingUser;
    try std.testing.expectEqualStrings(
        user_name,
        user.user_name,
    );

    _ = try shared_client.deleteUser(
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );

    user_name = "";
}

test "listPolicies returns policies" {
    const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const result = try shared_client.listPolicies(
        arena.allocator(),
        .{},
        .{},
    );

    try std.testing.expect(result.policies != null);
}
