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

    var client = iam.Client.init(allocator, &cfg);
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

test "IAM GetUser returns error for nonexistent user" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var cfg = try aws.Config.load(allocator, .{
        .endpoint_url = endpoint_url,
    });
    defer cfg.deinit();

    var client = iam.Client.init(allocator, &cfg);
    defer client.deinit();

    const result = iam.get_user.execute(
        &client,
        .{ .user_name = "nonexistent-user-12345" },
        .{},
    );

    try std.testing.expectError(error.ServiceError, result);
}
