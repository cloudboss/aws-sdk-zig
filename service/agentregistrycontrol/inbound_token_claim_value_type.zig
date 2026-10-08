const std = @import("std");

/// The value type of a claim in an inbound JWT.
pub const InboundTokenClaimValueType = enum {
    string,
    string_array,

    pub const json_field_names = .{
        .string = "STRING",
        .string_array = "STRING_ARRAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .string_array => "STRING_ARRAY",
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
