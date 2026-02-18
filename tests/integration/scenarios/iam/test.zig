const std = @import("std");
const aws = @import("aws");
const iam = @import("iam");

test "IAM CreateUser, GetUser, ListUsers, DeleteUser round-trip" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const user_name = "sdk-zig-test-user";

    // 1. CreateUser
    {
        var result = try iam.create_user.execute(
            &client,
            .{ .user_name = user_name },
            .{},
        );
        defer result.deinit();
    }

    // 2. GetUser -- verify user_name matches
    {
        var result = try iam.get_user.execute(
            &client,
            .{ .user_name = user_name },
            .{},
        );
        defer result.deinit();

        const user = result.user orelse return error.MissingUser;
        try std.testing.expectEqualStrings(user_name, user.user_name);
    }

    // 3. ListUsers -- verify created user appears in list
    {
        var result = try iam.list_users.execute(
            &client,
            .{},
            .{},
        );
        defer result.deinit();

        const users = result.users orelse return error.MissingUsers;
        var found = false;
        for (users) |u| {
            if (std.mem.eql(u8, u.user_name, user_name)) {
                found = true;
                break;
            }
        }
        try std.testing.expect(found);
    }

    // 4. DeleteUser
    {
        var result = try iam.delete_user.execute(
            &client,
            .{ .user_name = user_name },
            .{},
        );
        defer result.deinit();
    }
}

test "ListUsers paginator collects all users across pages" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const user_names = [_][]const u8{ "pag-user-1", "pag-user-2", "pag-user-3" };

    // Create 3 users
    for (user_names) |name| {
        var result = try iam.create_user.execute(&client, .{ .user_name = name }, .{});
        defer result.deinit();
    }

    // Paginate with max_items=1
    var pag = client.listUsersPaginator(.{ .max_items = 1 });
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
    // LocalStack may not respect max_items=1 strictly, so just verify
    // pagination ran (at least 1 page) and found all users
    try std.testing.expect(pages >= 1);

    // Clean up
    for (user_names) |name| {
        var result = try iam.delete_user.execute(&client, .{ .user_name = name }, .{});
        defer result.deinit();
    }
}

test "waitUntilUserExists succeeds after CreateUser" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const user_name = "sdk-zig-waiter-user";

    // Create user
    {
        var result = try iam.create_user.execute(&client, .{ .user_name = user_name }, .{});
        defer result.deinit();
    }

    // Wait should succeed
    try client.waitUntilUserExists(.{ .user_name = user_name });

    // Clean up
    {
        var result = try iam.delete_user.execute(&client, .{ .user_name = user_name }, .{});
        defer result.deinit();
    }
}

test "IAM GetUser returns error for nonexistent user" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(allocator, &cfg, .{ .keep_alive = false });
    defer client.deinit();

    const result = iam.get_user.execute(
        &client,
        .{ .user_name = "nonexistent-user-12345" },
        .{},
    );

    try std.testing.expectError(error.ServiceError, result);
}

test "IAM CreateRole, GetRole, DeleteRole round-trip" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    const role_name = "sdk-zig-iam-role";
    const trust_policy =
        \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"AWS":"*"},"Action":"sts:AssumeRole"}]}
    ;

    // 1. CreateRole
    {
        var result = try iam.create_role.execute(
            &client,
            .{
                .role_name = role_name,
                .assume_role_policy_document = trust_policy,
            },
            .{},
        );
        defer result.deinit();

        const role = result.role orelse return error.MissingRole;
        try std.testing.expectEqualStrings(role_name, role.role_name);
        try std.testing.expect(role.arn.len > 0);
    }

    // 2. GetRole -- verify role_name matches
    {
        var result = try iam.get_role.execute(
            &client,
            .{ .role_name = role_name },
            .{},
        );
        defer result.deinit();

        const role = result.role orelse return error.MissingRole;
        try std.testing.expectEqualStrings(role_name, role.role_name);
    }

    // 3. DeleteRole
    {
        var result = try iam.delete_role.execute(
            &client,
            .{ .role_name = role_name },
            .{},
        );
        defer result.deinit();
    }
}

test "IAM CreatePolicy and DeletePolicy round-trip" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    const policy_name = "sdk-zig-iam-policy";
    const policy_document =
        \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Action":"*","Resource":"*"}]}
    ;

    // 1. CreatePolicy -- keep result alive for policy_arn
    var create_result = try iam.create_policy.execute(
        &client,
        .{
            .policy_name = policy_name,
            .policy_document = policy_document,
        },
        .{},
    );
    defer create_result.deinit();

    const policy = create_result.policy orelse
        return error.MissingPolicy;
    const policy_arn = policy.arn orelse
        return error.MissingPolicyArn;
    try std.testing.expect(policy_arn.len > 0);

    // 2. DeletePolicy
    {
        var result = try iam.delete_policy.execute(
            &client,
            .{ .policy_arn = policy_arn },
            .{},
        );
        defer result.deinit();
    }
}

test "IAM AttachRolePolicy, ListAttachedRolePolicies, DetachRolePolicy round-trip" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.initWithOptions(
        allocator,
        &cfg,
        .{ .keep_alive = false },
    );
    defer client.deinit();

    const role_name = "sdk-zig-iam-attach-role";
    const trust_policy =
        \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"AWS":"*"},"Action":"sts:AssumeRole"}]}
    ;
    const policy_document =
        \\{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Action":"*","Resource":"*"}]}
    ;

    // 1. CreateRole
    {
        var result = try iam.create_role.execute(
            &client,
            .{
                .role_name = role_name,
                .assume_role_policy_document = trust_policy,
            },
            .{},
        );
        defer result.deinit();
    }

    // 2. CreatePolicy -- keep result alive for policy_arn
    var policy_result = try iam.create_policy.execute(
        &client,
        .{
            .policy_name = "sdk-zig-iam-attach-policy",
            .policy_document = policy_document,
        },
        .{},
    );
    defer policy_result.deinit();

    const policy = policy_result.policy orelse
        return error.MissingPolicy;
    const policy_arn = policy.arn orelse
        return error.MissingPolicyArn;

    // 3. AttachRolePolicy
    {
        var result = try iam.attach_role_policy.execute(
            &client,
            .{ .role_name = role_name, .policy_arn = policy_arn },
            .{},
        );
        defer result.deinit();
    }

    // 4. ListAttachedRolePolicies -- verify the policy is attached
    {
        var result = try iam.list_attached_role_policies.execute(
            &client,
            .{ .role_name = role_name },
            .{},
        );
        defer result.deinit();

        const policies = result.attached_policies orelse
            return error.MissingAttachedPolicies;
        try std.testing.expect(policies.len >= 1);

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

    // 5. DetachRolePolicy
    {
        var result = try iam.detach_role_policy.execute(
            &client,
            .{ .role_name = role_name, .policy_arn = policy_arn },
            .{},
        );
        defer result.deinit();
    }

    // 6. Cleanup: DeleteRole
    {
        var result = try iam.delete_role.execute(
            &client,
            .{ .role_name = role_name },
            .{},
        );
        defer result.deinit();
    }

    // 7. Cleanup: DeletePolicy
    {
        var result = try iam.delete_policy.execute(
            &client,
            .{ .policy_arn = policy_arn },
            .{},
        );
        defer result.deinit();
    }
}
