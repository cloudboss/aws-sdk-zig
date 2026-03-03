const std = @import("std");

pub const StoreType = enum {
    sequence_store,
    reference_store,

    pub const json_field_names = .{
        .sequence_store = "SEQUENCE_STORE",
        .reference_store = "REFERENCE_STORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sequence_store => "SEQUENCE_STORE",
            .reference_store => "REFERENCE_STORE",
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
