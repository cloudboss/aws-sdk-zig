const std = @import("std");

pub const JobErrorResourceTypes = enum {
    revision,
    asset,
    data_set,

    pub const json_field_names = .{
        .revision = "REVISION",
        .asset = "ASSET",
        .data_set = "DATA_SET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .revision => "REVISION",
            .asset => "ASSET",
            .data_set => "DATA_SET",
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
