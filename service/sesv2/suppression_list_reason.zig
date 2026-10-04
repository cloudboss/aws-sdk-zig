const std = @import("std");

/// The reason that the address was added to the suppression list for your
/// account or for
/// a specific tenant. The value can be one of the following:
///
/// * `COMPLAINT` – Amazon SES added an email address to the suppression
/// list for your account or for a specific tenant because a message sent to
/// that
/// address results in a complaint.
///
/// * `BOUNCE` – Amazon SES added an email address to the suppression
/// list for your account or for a specific tenant because a message sent to
/// that
/// address results in a hard bounce.
pub const SuppressionListReason = enum {
    bounce,
    complaint,

    pub const json_field_names = .{
        .bounce = "BOUNCE",
        .complaint = "COMPLAINT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bounce => "BOUNCE",
            .complaint => "COMPLAINT",
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
