const std = @import("std");

/// Specifies whether a broker is a part of a data replication pair.
pub const DataReplicationMode = enum {
    none,
    crdr,

    pub const json_field_names = .{
        .none = "NONE",
        .crdr = "CRDR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .crdr => "CRDR",
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
