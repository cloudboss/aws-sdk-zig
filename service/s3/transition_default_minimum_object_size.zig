const std = @import("std");

pub const TransitionDefaultMinimumObjectSize = enum {
    varies_by_storage_class,
    all_storage_classes_128_k,

    pub const json_field_names = .{
        .varies_by_storage_class = "varies_by_storage_class",
        .all_storage_classes_128_k = "all_storage_classes_128K",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .varies_by_storage_class => "varies_by_storage_class",
            .all_storage_classes_128_k => "all_storage_classes_128K",
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
