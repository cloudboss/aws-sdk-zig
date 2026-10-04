const std = @import("std");

/// The type of a service-linked recorder.
///
/// * `AWS` – Managed by an Amazon Web Services service.
/// * `THIRD_PARTY` – Managed by a third-party service.
pub const RecorderType = enum {
    aws,
    third_party,

    pub const json_field_names = .{
        .aws = "AWS",
        .third_party = "THIRD_PARTY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "AWS",
            .third_party => "THIRD_PARTY",
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
