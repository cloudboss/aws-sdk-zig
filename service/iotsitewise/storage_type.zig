const std = @import("std");

pub const StorageType = enum {
    sitewise_default_storage,
    multi_layer_storage,

    pub const json_field_names = .{
        .sitewise_default_storage = "SITEWISE_DEFAULT_STORAGE",
        .multi_layer_storage = "MULTI_LAYER_STORAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sitewise_default_storage => "SITEWISE_DEFAULT_STORAGE",
            .multi_layer_storage => "MULTI_LAYER_STORAGE",
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
