const std = @import("std");
const aws = @import("aws");

test "assume role provider gets temporary credentials" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    // Source credentials: static from test environment
    var source = aws.CredentialsProvider{
        .static = .{
            .access_key_id = "test",
            .secret_access_key = "test",
        },
    };

    var provider = aws.assume_role.AssumeRoleProvider{
        .role_arn = "arn:aws:iam::000000000000:role/phase8-assume-role-test",
        .session_name = "integration-test",
        .external_id = null,
        .region = "us-east-1",
        .source_provider = &source,
        .endpoint_url = endpoint_url,
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify we got temporary credentials
    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.secret_access_key.len > 0);
    try std.testing.expect(creds.session_token != null);
    try std.testing.expect(creds.expiration != null);
}

test "assume role with external id" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var source = aws.CredentialsProvider{
        .static = .{
            .access_key_id = "test",
            .secret_access_key = "test",
        },
    };

    var provider = aws.assume_role.AssumeRoleProvider{
        .role_arn = "arn:aws:iam::000000000000:role/phase8-assume-role-test",
        .session_name = "external-id-test",
        .external_id = "my-external-id-123",
        .region = "us-east-1",
        .source_provider = &source,
        .endpoint_url = endpoint_url,
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify credentials were returned even with external_id
    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.session_token != null);
}

test "assume role works via CredentialsProvider union" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var source = aws.CredentialsProvider{
        .static = .{
            .access_key_id = "test",
            .secret_access_key = "test",
        },
    };

    var cp = aws.CredentialsProvider{
        .assume_role = .{
            .role_arn = "arn:aws:iam::000000000000:role/phase8-assume-role-test",
            .session_name = "union-test",
            .external_id = null,
            .region = "us-east-1",
            .source_provider = &source,
            .endpoint_url = endpoint_url,
        },
    };

    const creds = try cp.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expect(creds.access_key_id.len > 0);
}

test "assumed role session token has substantial length" {
    const allocator = std.testing.allocator;

    const endpoint_url = std.posix.getenv("AWS_ENDPOINT_URL") orelse
        return error.MissingEndpoint;

    var source = aws.CredentialsProvider{
        .static = .{
            .access_key_id = "test",
            .secret_access_key = "test",
        },
    };

    var provider = aws.assume_role.AssumeRoleProvider{
        .role_arn = "arn:aws:iam::000000000000:role/phase8-assume-role-test",
        .session_name = "verify-session-name",
        .external_id = null,
        .region = "us-east-1",
        .source_provider = &source,
        .endpoint_url = endpoint_url,
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify session token is non-null and has substantial length
    try std.testing.expect(creds.session_token != null);
    try std.testing.expect(creds.session_token.?.len > 20);
}
