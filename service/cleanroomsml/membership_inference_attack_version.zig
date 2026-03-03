const std = @import("std");

pub const MembershipInferenceAttackVersion = enum {
    distance_to_closest_record_v1,

    pub const json_field_names = .{
        .distance_to_closest_record_v1 = "DISTANCE_TO_CLOSEST_RECORD_V1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .distance_to_closest_record_v1 => "DISTANCE_TO_CLOSEST_RECORD_V1",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
