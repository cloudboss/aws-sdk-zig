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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
