/// Verify that generated structs with optional fields default to null,
/// allowing partial initialization.
const std = @import("std");
const ec2 = @import("ec2");
const sts = @import("sts");
const s3 = @import("s3");
const dynamodb = @import("dynamodb");

test "shared struct optional fields default to null" {
    // EC2 VolumeAttachment: all fields optional — constructible with .{}
    const attachment: ec2.types.VolumeAttachment = .{};
    try std.testing.expectEqual(null, attachment.volume_id);
    try std.testing.expectEqual(null, attachment.instance_id);
    try std.testing.expectEqual(null, attachment.state);
    try std.testing.expectEqual(null, attachment.attach_time);
    try std.testing.expectEqual(null, attachment.delete_on_termination);
}

test "shared struct partial initialization" {
    // EC2 Filter: set only the fields we care about
    const filter: ec2.types.Filter = .{
        .name = "status",
    };
    try std.testing.expectEqualStrings("status", filter.name.?);
    try std.testing.expectEqual(null, filter.values);
}

test "operation input partial initialization" {
    // STS GetCallerIdentity has no required fields
    const input: sts.GetCallerIdentityInput = .{};
    _ = input;

    // DynamoDB ListTables has all optional input fields
    const list_input: dynamodb.ListTablesInput = .{};
    try std.testing.expectEqual(null, list_input.exclusive_start_table_name);
    try std.testing.expectEqual(null, list_input.limit);
}

test "operation input with required and optional fields" {
    // S3 GetObject: bucket and key are required
    const input: s3.GetObjectInput = .{
        .bucket = "my-bucket",
        .key = "my-key",
    };
    try std.testing.expectEqualStrings("my-bucket", input.bucket);
    try std.testing.expectEqualStrings("my-key", input.key);
    // Optional fields default to null
    try std.testing.expectEqual(null, input.range);
    try std.testing.expectEqual(null, input.if_match);
}

test "operation output fields default to null" {
    // STS GetCallerIdentityOutput: all fields optional
    const output: sts.GetCallerIdentityOutput = .{};
    try std.testing.expectEqual(null, output.account);
    try std.testing.expectEqual(null, output.arn);
    try std.testing.expectEqual(null, output.user_id);
}
