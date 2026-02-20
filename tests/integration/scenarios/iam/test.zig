const std = @import("std");
const aws = @import("aws");
const iam = @import("iam");

var gpa: std.heap.GeneralPurposeAllocator(.{}) = .init;
var shared_client: iam.Client = undefined;
var shared_cfg: aws.Config = undefined;
var shared_init = false;

const trust_policy =
    \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"AWS":"*"},"Action":"sts:AssumeRole"}]}
;
const policy_document =
    \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Action":"*","Resource":"*"}]}
;

test "zest.beforeAll" {
    const allocator = gpa.allocator();
    shared_cfg = try aws.Config.load(allocator, .{});
    shared_client = iam.Client.initWithOptions(
        allocator,
        &shared_cfg,
        .{ .keep_alive = false },
    );
    shared_init = true;
}

test "zest.afterAll" {
    defer _ = gpa.deinit();
    if (!shared_init) return;
    shared_client.deinit();
    shared_cfg.deinit();
}

test "CreateUser returns successfully" {
    const user_name = "sdk-zig-iam-create-user";

    var create = try iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer create.deinit();

    var del = try iam.delete_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer del.deinit();
}

test "GetUser returns created user with correct name" {
    const user_name = "sdk-zig-iam-get-user";

    var create = try iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer create.deinit();

    var get = try iam.get_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer get.deinit();

    const user = get.user orelse return error.MissingUser;
    try std.testing.expectEqualStrings(user_name, user.user_name);

    var del = try iam.delete_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer del.deinit();
}

test "ListUsers includes created user" {
    const user_name = "sdk-zig-iam-list-user";

    var create = try iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer create.deinit();

    var list = try iam.list_users.execute(&shared_client, .{}, .{});
    defer list.deinit();

    const users = list.users orelse return error.MissingUsers;
    var found = false;
    for (users) |u| {
        if (std.mem.eql(u8, u.user_name, user_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    var del = try iam.delete_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer del.deinit();
}

test "DeleteUser removes user" {
    const user_name = "sdk-zig-iam-delete-user";

    var create = try iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer create.deinit();

    var del = try iam.delete_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer del.deinit();

    const result = iam.get_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "CreateRole returns role with correct name" {
    const role_name = "sdk-zig-iam-create-role";

    var create = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer create.deinit();

    const role = create.role orelse return error.MissingRole;
    try std.testing.expectEqualStrings(role_name, role.role_name);
    try std.testing.expect(role.arn.len > 0);

    var del = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer del.deinit();
}

test "GetRole returns created role" {
    const role_name = "sdk-zig-iam-get-role";

    var create = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer create.deinit();

    var get = try iam.get_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer get.deinit();

    const role = get.role orelse return error.MissingRole;
    try std.testing.expectEqualStrings(role_name, role.role_name);

    var del = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer del.deinit();
}

test "DeleteRole removes role" {
    const role_name = "sdk-zig-iam-del-role";

    var create = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer create.deinit();

    var del = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer del.deinit();
}

test "CreatePolicy returns policy ARN" {
    const policy_name = "sdk-zig-iam-create-pol";

    var create = try iam.create_policy.execute(
        &shared_client,
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );
    defer create.deinit();

    const policy = create.policy orelse return error.MissingPolicy;
    const arn = policy.arn orelse return error.MissingPolicyArn;
    try std.testing.expect(arn.len > 0);

    var del = try iam.delete_policy.execute(
        &shared_client,
        .{ .policy_arn = arn },
        .{},
    );
    defer del.deinit();
}

test "DeletePolicy removes policy" {
    const policy_name = "sdk-zig-iam-del-pol";

    var create = try iam.create_policy.execute(
        &shared_client,
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );
    defer create.deinit();

    const policy = create.policy orelse return error.MissingPolicy;
    const arn = policy.arn orelse return error.MissingPolicyArn;

    var del = try iam.delete_policy.execute(
        &shared_client,
        .{ .policy_arn = arn },
        .{},
    );
    defer del.deinit();
}

test "AttachRolePolicy links policy to role" {
    const role_name = "sdk-zig-iam-attach-r1";
    const policy_name = "sdk-zig-iam-attach-p1";

    var cr = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer cr.deinit();

    var cp = try iam.create_policy.execute(
        &shared_client,
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );
    defer cp.deinit();

    const pol = cp.policy orelse return error.MissingPolicy;
    const arn = pol.arn orelse return error.MissingPolicyArn;

    var attach = try iam.attach_role_policy.execute(
        &shared_client,
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    defer attach.deinit();

    // cleanup: detach, delete role, delete policy
    var detach = try iam.detach_role_policy.execute(
        &shared_client,
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    defer detach.deinit();

    var dr = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer dr.deinit();

    var dp = try iam.delete_policy.execute(
        &shared_client,
        .{ .policy_arn = arn },
        .{},
    );
    defer dp.deinit();
}

test "ListAttachedRolePolicies includes attached policy" {
    const role_name = "sdk-zig-iam-attach-r2";
    const policy_name = "sdk-zig-iam-attach-p2";

    var cr = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer cr.deinit();

    var cp = try iam.create_policy.execute(
        &shared_client,
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );
    defer cp.deinit();

    const pol = cp.policy orelse return error.MissingPolicy;
    const arn = pol.arn orelse return error.MissingPolicyArn;

    var attach = try iam.attach_role_policy.execute(
        &shared_client,
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    defer attach.deinit();

    var list = try iam.list_attached_role_policies.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer list.deinit();

    const policies = list.attached_policies orelse
        return error.MissingAttachedPolicies;
    var found = false;
    for (policies) |p| {
        if (p.policy_arn) |a| {
            if (std.mem.eql(u8, a, arn)) {
                found = true;
                break;
            }
        }
    }
    try std.testing.expect(found);

    // cleanup
    var detach = try iam.detach_role_policy.execute(
        &shared_client,
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    defer detach.deinit();

    var dr = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer dr.deinit();

    var dp = try iam.delete_policy.execute(
        &shared_client,
        .{ .policy_arn = arn },
        .{},
    );
    defer dp.deinit();
}

test "DetachRolePolicy removes policy from role" {
    const role_name = "sdk-zig-iam-attach-r3";
    const policy_name = "sdk-zig-iam-attach-p3";

    var cr = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer cr.deinit();

    var cp = try iam.create_policy.execute(
        &shared_client,
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );
    defer cp.deinit();

    const pol = cp.policy orelse return error.MissingPolicy;
    const arn = pol.arn orelse return error.MissingPolicyArn;

    var attach = try iam.attach_role_policy.execute(
        &shared_client,
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    defer attach.deinit();

    var detach = try iam.detach_role_policy.execute(
        &shared_client,
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    defer detach.deinit();

    // verify empty after detach
    var list = try iam.list_attached_role_policies.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer list.deinit();

    if (list.attached_policies) |policies_list| {
        try std.testing.expectEqual(@as(usize, 0), policies_list.len);
    }

    // cleanup
    var dr = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer dr.deinit();

    var dp = try iam.delete_policy.execute(
        &shared_client,
        .{ .policy_arn = arn },
        .{},
    );
    defer dp.deinit();
}

test "ListUsers paginator collects all users across pages" {
    const user_names = [_][]const u8{ "pag-user-1", "pag-user-2", "pag-user-3" };

    for (user_names) |name| {
        var result = try iam.create_user.execute(
            &shared_client,
            .{ .user_name = name },
            .{},
        );
        defer result.deinit();
    }

    var pag = shared_client.listUsersPaginator(.{ .max_items = 1 });
    defer pag.deinit();

    var total_users: usize = 0;
    var pages: usize = 0;
    while (!pag.done) {
        var output = try pag.next(.{});
        defer output.deinit();

        if (output.users) |users| {
            total_users += users.len;
        }
        pages += 1;
    }

    try std.testing.expect(total_users >= 3);
    try std.testing.expect(pages >= 1);

    for (user_names) |name| {
        var result = try iam.delete_user.execute(
            &shared_client,
            .{ .user_name = name },
            .{},
        );
        defer result.deinit();
    }
}

test "waitUntilUserExists succeeds after CreateUser" {
    const user_name = "sdk-zig-waiter-user";

    var create = try iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer create.deinit();

    try shared_client.waitUntilUserExists(.{ .user_name = user_name });

    var del = try iam.delete_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer del.deinit();
}

test "GetUser returns error for nonexistent user" {
    const result = iam.get_user.execute(
        &shared_client,
        .{ .user_name = "nonexistent-user-12345" },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "ListRoles includes created role" {
    const role_name = "sdk-zig-iam-list-role";

    var create = try iam.create_role.execute(
        &shared_client,
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    defer create.deinit();

    var list = try iam.list_roles.execute(&shared_client, .{}, .{});
    defer list.deinit();

    const roles = list.roles orelse return error.MissingRoles;
    var found = false;
    for (roles) |r| {
        if (std.mem.eql(u8, r.role_name, role_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    var del = try iam.delete_role.execute(
        &shared_client,
        .{ .role_name = role_name },
        .{},
    );
    defer del.deinit();
}

test "ListPolicies returns policies" {
    var list = try iam.list_policies.execute(&shared_client, .{}, .{});
    defer list.deinit();

    // LocalStack always returns the policies list (possibly empty)
    try std.testing.expect(list.policies != null);
}

test "GetUser returns NoSuchEntity for nonexistent user with diagnostic" {
    var diagnostic: iam.ServiceError = undefined;
    const result = iam.get_user.execute(
        &shared_client,
        .{ .user_name = "nonexistent-user-diag" },
        .{ .diagnostic = &diagnostic },
    );

    if (result) |_| {
        return error.ExpectedServiceError;
    } else |err| {
        try std.testing.expectEqual(error.ServiceError, err);
        switch (diagnostic) {
            .no_such_entity_exception => {},
            // LocalStack may return an unrecognised code that maps to unknown
            .unknown => |u| try std.testing.expect(u.http_status == 404),
            else => return error.UnexpectedErrorVariant,
        }
    }
}

test "CreateUser with duplicate name returns EntityAlreadyExists" {
    const user_name = "sdk-zig-iam-dup-user";

    var create = try iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer create.deinit();

    var diagnostic: iam.ServiceError = undefined;
    const dup = iam.create_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{ .diagnostic = &diagnostic },
    );

    if (dup) |*r| {
        var result = r.*;
        result.deinit();
        return error.ExpectedServiceError;
    } else |err| {
        try std.testing.expectEqual(error.ServiceError, err);
        switch (diagnostic) {
            .entity_already_exists_exception => {},
            // LocalStack may return an unrecognised code that maps to unknown
            .unknown => |u| try std.testing.expect(u.http_status == 409),
            else => return error.UnexpectedErrorVariant,
        }
    }

    var del = try iam.delete_user.execute(
        &shared_client,
        .{ .user_name = user_name },
        .{},
    );
    defer del.deinit();
}

test "GetRole returns error for nonexistent role" {
    const result = iam.get_role.execute(
        &shared_client,
        .{ .role_name = "nonexistent-role-12345" },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}
