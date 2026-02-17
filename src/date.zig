//! ISO 8601 timestamp parsing
//!
//! Parses ISO 8601 formatted timestamps (e.g., "2024-01-15T12:00:00Z")
//! and converts them to Unix epoch seconds.

const std = @import("std");

pub fn parseIso8601(timestamp: []const u8) !i64 {
    // Format: 2024-01-15T12:00:00Z
    if (timestamp.len < 19) return error.InvalidTimestamp;

    // Validate separators
    if (timestamp[4] != '-' or timestamp[7] != '-' or
        timestamp[10] != 'T' or timestamp[13] != ':' or timestamp[16] != ':')
        return error.InvalidTimestamp;

    const year = std.fmt.parseInt(u16, timestamp[0..4], 10) catch return error.InvalidTimestamp;
    const month = std.fmt.parseInt(u4, timestamp[5..7], 10) catch return error.InvalidTimestamp;
    const day = std.fmt.parseInt(u5, timestamp[8..10], 10) catch return error.InvalidTimestamp;
    const hour = std.fmt.parseInt(u5, timestamp[11..13], 10) catch return error.InvalidTimestamp;
    const minute = std.fmt.parseInt(u6, timestamp[14..16], 10) catch return error.InvalidTimestamp;
    const second = std.fmt.parseInt(u6, timestamp[17..19], 10) catch return error.InvalidTimestamp;

    // Calculate epoch day manually (days since 1970-01-01)
    const epoch_day = yearDayToEpochDay(year, try dayOfYear(year, month, day));

    const day_seconds = @as(i64, hour) * 3600 + @as(i64, minute) * 60 + @as(i64, second);
    return epoch_day * 86400 + day_seconds;
}

/// Convert year and day-of-year to epoch day (days since 1970-01-01)
fn yearDayToEpochDay(year: u16, day_of_year: u9) i64 {
    var days: i64 = day_of_year;

    // Count days from 1970 to target year
    if (year >= 1970) {
        var y: u16 = 1970;
        while (y < year) : (y += 1) {
            days += if (isLeapYear(y)) 366 else 365;
        }
    } else {
        var y: u16 = year;
        while (y < 1970) : (y += 1) {
            days -= if (isLeapYear(y)) 366 else 365;
        }
    }

    return days;
}

/// Calculate day of year (0-indexed)
fn dayOfYear(year: u16, month: u4, day: u5) error{InvalidTimestamp}!u9 {
    if (month == 0 or month > 12 or day == 0) return error.InvalidTimestamp;
    const days_before_month = [_]u16{ 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 };
    var result: u16 = days_before_month[month - 1] + day - 1;

    // Add leap day if applicable
    if (month > 2 and isLeapYear(year)) {
        result += 1;
    }

    return @intCast(result);
}

fn isLeapYear(year: u16) bool {
    if (@mod(year, 4) != 0) return false;
    if (@mod(year, 100) != 0) return true;
    return @mod(year, 400) == 0;
}

test "parseIso8601" {
    // 2024-01-15T12:00:00Z
    const ts = try parseIso8601("2024-01-15T12:00:00Z");
    // Verify it's approximately correct (within a day of expected)
    try std.testing.expect(ts > 1705300000);
    try std.testing.expect(ts < 1705400000);
}

test "dayOfYear" {
    // Jan 1 = day 0
    try std.testing.expectEqual(@as(u9, 0), try dayOfYear(2024, 1, 1));
    // Feb 1 = day 31
    try std.testing.expectEqual(@as(u9, 31), try dayOfYear(2024, 2, 1));
    // Mar 1 in leap year = day 60
    try std.testing.expectEqual(@as(u9, 60), try dayOfYear(2024, 3, 1));
    // Mar 1 in non-leap year = day 59
    try std.testing.expectEqual(@as(u9, 59), try dayOfYear(2023, 3, 1));
}

test "isLeapYear" {
    try std.testing.expect(isLeapYear(2024));
    try std.testing.expect(!isLeapYear(2023));
    try std.testing.expect(!isLeapYear(1900));
    try std.testing.expect(isLeapYear(2000));
}

test "parseIso8601 exact epoch value" {
    // Unix epoch: 1970-01-01T00:00:00Z = 0
    const ts = try parseIso8601("1970-01-01T00:00:00Z");
    try std.testing.expectEqual(@as(i64, 0), ts);
}

test "parseIso8601 known timestamp" {
    // 2024-01-15T12:00:00Z = 1705320000 (verified externally)
    const ts = try parseIso8601("2024-01-15T12:00:00Z");
    try std.testing.expectEqual(@as(i64, 1705320000), ts);
}

test "parseIso8601 end of day" {
    // 1970-01-01T23:59:59Z = 86399
    const ts = try parseIso8601("1970-01-01T23:59:59Z");
    try std.testing.expectEqual(@as(i64, 86399), ts);
}

test "parseIso8601 returns error for too-short string" {
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("2024-01-15"));
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601(""));
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("short"));
}

test "parseIso8601 returns error for invalid separators" {
    // Missing dashes
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("20240115T12:00:00Z"));
    // Missing T
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("2024-01-15 12:00:00Z"));
    // Missing colons
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("2024-01-15T120000Z_"));
}

test "parseIso8601 returns error for zero month" {
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("2024-00-15T12:00:00Z"));
}

test "parseIso8601 returns error for zero day" {
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("2024-01-00T12:00:00Z"));
}

test "parseIso8601 returns error for non-numeric fields" {
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("XXXX-01-15T12:00:00Z"));
    try std.testing.expectError(error.InvalidTimestamp, parseIso8601("2024-XX-15T12:00:00Z"));
}
