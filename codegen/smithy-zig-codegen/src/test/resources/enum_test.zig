const std = @import("std");
const Status = @import("status.zig").Status;
const LegacyStatus = @import("legacy_status.zig").LegacyStatus;
const LargeStatus = @import("large_status.zig").LargeStatus;

test "generated enum values and fallback names" {
    try std.testing.expectEqual(@as(?Status, .active), Status.fromWireName("ACTIVE"));
    try std.testing.expectEqual(@as(?Status, .pending), Status.fromWireName("waiting"));
    try std.testing.expectEqual(@as(?Status, .pending), Status.fromWireName("pending"));
    try std.testing.expectEqual(@as(?Status, .type), Status.fromWireName("TYPE"));
    try std.testing.expectEqual(null, Status.fromWireName("unknown"));
    try std.testing.expectEqualStrings("waiting", Status.pending.wireName());
    try std.testing.expectEqual(@as(?LegacyStatus, .active), LegacyStatus.fromWireName("ACTIVE"));
    try std.testing.expectEqualStrings("ACTIVE", LegacyStatus.active.wireName());
    try std.testing.expectEqual(
        @as(?LargeStatus, .value_399),
        LargeStatus.fromWireName("VALUE-399"),
    );
    try std.testing.expectEqual(null, LargeStatus.fromWireName("unknown"));
}
