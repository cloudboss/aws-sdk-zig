const std = @import("std");

/// The type of pending change on a subscription.
///
/// Possible values:
///
/// * `DOWNGRADE` — The subscription tier is being lowered at the end of the
///   billing period.
/// * `CANCELLATION` — The subscription is being terminated at the end of the
///   billing period.
pub const ScheduledChangeType = enum {
    downgrade,
    cancellation,

    pub const json_field_names = .{
        .downgrade = "DOWNGRADE",
        .cancellation = "CANCELLATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .downgrade => "DOWNGRADE",
            .cancellation => "CANCELLATION",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
