const std = @import("std");

/// The ungraceful behavior for an AWS Systems Manager `SendCommand` execution
/// block, which must be set to `skip`.
pub const SsmSendCommandUngracefulBehavior = enum {
    skip,

    pub const json_field_names = .{
        .skip = "skip",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .skip => "skip",
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
