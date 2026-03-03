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
    if (!shared_init) {
        _ = gpa.deinit();
        return;
    }
    shared_client.deinit();
    shared_cfg.deinit();
    try std.testing.expect(gpa.deinit() == .ok);
}

test "CreateUser returns successfully" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-iam-create-user";

    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = create;

    const del = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = del;
}

test "CreateUser with explicit Tag type" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-iam-tag-user";

    const tags = [_]iam.types.Tag{
        .{ .key = "env", .value = "test" },
        .{ .key = "project", .value = "sdk-zig" },
    };
    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name, .tags = &tags },
        .{},
    );

    const user = create.user orelse return error.MissingUser;
    try std.testing.expectEqualStrings(user_name, user.user_name);

    _ = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
}

test "GetUser returns created user with correct name" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-iam-get-user";

    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = create;

    const get = try iam.get_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );

    const user = get.user orelse return error.MissingUser;
    try std.testing.expectEqualStrings(user_name, user.user_name);

    const del = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = del;
}

test "ListUsers includes created user" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-iam-list-user";

    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = create;

    const list = try iam.list_users.execute(&shared_client, arena.allocator(), .{}, .{});

    const users = list.users orelse return error.MissingUsers;
    var found = false;
    for (users) |u| {
        if (std.mem.eql(u8, u.user_name, user_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    const del = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = del;
}

test "DeleteUser removes user" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-iam-delete-user";

    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = create;

    const del = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = del;

    const result = iam.get_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "CreateRole returns role with correct name" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-create-role";

    const create = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );

    const role = create.role orelse return error.MissingRole;
    try std.testing.expectEqualStrings(role_name, role.role_name);
    try std.testing.expect(role.arn.len > 0);

    const del = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = del;
}

test "GetRole returns created role" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-get-role";

    const create = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    _ = create;

    const get = try iam.get_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );

    const role = get.role orelse return error.MissingRole;
    try std.testing.expectEqualStrings(role_name, role.role_name);

    const del = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = del;
}

test "DeleteRole removes role" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-del-role";

    const create = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    _ = create;

    const del = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = del;
}

test "CreatePolicy returns policy ARN" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const policy_name = "sdk-zig-iam-create-pol";

    const create = try iam.create_policy.execute(
        &shared_client,
        arena.allocator(),
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );

    const policy = create.policy orelse return error.MissingPolicy;
    const arn = policy.arn orelse return error.MissingPolicyArn;
    try std.testing.expect(arn.len > 0);

    const del = try iam.delete_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .policy_arn = arn },
        .{},
    );
    _ = del;
}

test "DeletePolicy removes policy" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const policy_name = "sdk-zig-iam-del-pol";

    const create = try iam.create_policy.execute(
        &shared_client,
        arena.allocator(),
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );

    const policy = create.policy orelse return error.MissingPolicy;
    const arn = policy.arn orelse return error.MissingPolicyArn;

    const del = try iam.delete_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .policy_arn = arn },
        .{},
    );
    _ = del;
}

test "AttachRolePolicy links policy to role" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-attach-r1";
    const policy_name = "sdk-zig-iam-attach-p1";

    const cr = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    _ = cr;

    const cp = try iam.create_policy.execute(
        &shared_client,
        arena.allocator(),
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );

    const pol = cp.policy orelse return error.MissingPolicy;
    const arn = pol.arn orelse return error.MissingPolicyArn;

    const attach = try iam.attach_role_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    _ = attach;

    // cleanup: detach, delete role, delete policy
    const detach = try iam.detach_role_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    _ = detach;

    const dr = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = dr;

    const dp = try iam.delete_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .policy_arn = arn },
        .{},
    );
    _ = dp;
}

test "ListAttachedRolePolicies includes attached policy" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-attach-r2";
    const policy_name = "sdk-zig-iam-attach-p2";

    const cr = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    _ = cr;

    const cp = try iam.create_policy.execute(
        &shared_client,
        arena.allocator(),
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );

    const pol = cp.policy orelse return error.MissingPolicy;
    const arn = pol.arn orelse return error.MissingPolicyArn;

    const attach = try iam.attach_role_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    _ = attach;

    const list = try iam.list_attached_role_policies.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );

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
    const detach = try iam.detach_role_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    _ = detach;

    const dr = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = dr;

    const dp = try iam.delete_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .policy_arn = arn },
        .{},
    );
    _ = dp;
}

test "DetachRolePolicy removes policy from role" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-attach-r3";
    const policy_name = "sdk-zig-iam-attach-p3";

    const cr = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    _ = cr;

    const cp = try iam.create_policy.execute(
        &shared_client,
        arena.allocator(),
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );

    const pol = cp.policy orelse return error.MissingPolicy;
    const arn = pol.arn orelse return error.MissingPolicyArn;

    const attach = try iam.attach_role_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    _ = attach;

    const detach = try iam.detach_role_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name, .policy_arn = arn },
        .{},
    );
    _ = detach;

    // verify empty after detach
    const list = try iam.list_attached_role_policies.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );

    if (list.attached_policies) |policies_list| {
        try std.testing.expectEqual(@as(usize, 0), policies_list.len);
    }

    // cleanup
    const dr = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = dr;

    const dp = try iam.delete_policy.execute(
        &shared_client,
        arena.allocator(),
        .{ .policy_arn = arn },
        .{},
    );
    _ = dp;
}

test "ListUsers paginator collects all users across pages" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_names = [_][]const u8{ "pag-user-1", "pag-user-2", "pag-user-3" };

    for (user_names) |name| {
        const result = try iam.create_user.execute(
            &shared_client,
            arena.allocator(),
            .{ .user_name = name },
            .{},
        );
        _ = result;
    }

    var pag = shared_client.listUsersPaginator(.{ .max_items = 1 });
    defer pag.deinit();

    var total_users: usize = 0;
    var pages: usize = 0;
    while (!pag.done) {
        const output = try pag.next(arena.allocator(), .{});

        if (output.users) |users| {
            total_users += users.len;
        }
        pages += 1;
    }

    try std.testing.expect(total_users >= 3);
    try std.testing.expect(pages >= 1);

    for (user_names) |name| {
        const result = try iam.delete_user.execute(
            &shared_client,
            arena.allocator(),
            .{ .user_name = name },
            .{},
        );
        _ = result;
    }
}

test "waitUntilUserExists succeeds after CreateUser" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-waiter-user";

    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = create;

    try shared_client.waitUntilUserExists(.{ .user_name = user_name });

    const del = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = del;
}

test "GetUser returns error for nonexistent user" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = iam.get_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = "nonexistent-user-12345" },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}

test "ListRoles includes created role" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const role_name = "sdk-zig-iam-list-role";

    const create = try iam.create_role.execute(
        &shared_client,
        arena.allocator(),
        .{
            .role_name = role_name,
            .assume_role_policy_document = trust_policy,
        },
        .{},
    );
    _ = create;

    const list = try iam.list_roles.execute(&shared_client, arena.allocator(), .{}, .{});

    const roles = list.roles orelse return error.MissingRoles;
    var found = false;
    for (roles) |r| {
        if (std.mem.eql(u8, r.role_name, role_name)) {
            found = true;
            break;
        }
    }
    try std.testing.expect(found);

    const del = try iam.delete_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = role_name },
        .{},
    );
    _ = del;
}

test "ListPolicies returns policies" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const list = try iam.list_policies.execute(&shared_client, arena.allocator(), .{}, .{});

    // LocalStack always returns the policies list (possibly empty)
    try std.testing.expect(list.policies != null);
}

test "GetUser returns NoSuchEntity for nonexistent user with diagnostic" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    var diagnostic: iam.ServiceError = undefined;
    const result = iam.get_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = "nonexistent-user-diag" },
        .{ .diagnostic = &diagnostic },
    );

    if (result) |_| {
        return error.ExpectedServiceError;
    } else |err| {
        try std.testing.expectEqual(error.ServiceError, err);
        defer diagnostic.deinit();
        switch (diagnostic.kind) {
            .no_such_entity_exception => {},
            // LocalStack may return an unrecognised code that maps to unknown
            .unknown => |u| try std.testing.expect(u.http_status == 404),
            else => return error.UnexpectedErrorVariant,
        }
    }
}

test "CreateUser with duplicate name returns EntityAlreadyExists" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const user_name = "sdk-zig-iam-dup-user";

    const create = try iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = create;

    var diagnostic: iam.ServiceError = undefined;
    const dup = iam.create_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{ .diagnostic = &diagnostic },
    );

    if (dup) |_| {
        return error.ExpectedServiceError;
    } else |err| {
        try std.testing.expectEqual(error.ServiceError, err);
        defer diagnostic.deinit();
        switch (diagnostic.kind) {
            .entity_already_exists_exception => {},
            // LocalStack may return an unrecognised code that maps to unknown
            .unknown => |u| try std.testing.expect(u.http_status == 409),
            else => return error.UnexpectedErrorVariant,
        }
    }

    const del = try iam.delete_user.execute(
        &shared_client,
        arena.allocator(),
        .{ .user_name = user_name },
        .{},
    );
    _ = del;
}

test "GetRole returns error for nonexistent role" {
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    defer arena.deinit();

    const result = iam.get_role.execute(
        &shared_client,
        arena.allocator(),
        .{ .role_name = "nonexistent-role-12345" },
        .{},
    );
    try std.testing.expectError(error.ServiceError, result);
}
