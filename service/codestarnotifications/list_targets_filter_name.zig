const std = @import("std");

pub const ListTargetsFilterName = enum {
    target_type,
    target_address,
    target_status,

    pub const json_field_names = .{
        .target_type = "TARGET_TYPE",
        .target_address = "TARGET_ADDRESS",
        .target_status = "TARGET_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .target_type => "TARGET_TYPE",
            .target_address => "TARGET_ADDRESS",
            .target_status => "TARGET_STATUS",
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
