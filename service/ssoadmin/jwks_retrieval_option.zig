const std = @import("std");

pub const JwksRetrievalOption = enum {
    open_id_discovery,

    pub const json_field_names = .{
        .open_id_discovery = "OPEN_ID_DISCOVERY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .open_id_discovery => "OPEN_ID_DISCOVERY",
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
