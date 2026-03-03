const std = @import("std");

pub const StorageClass = enum {
    standard,
    reduced_redundancy,
    standard_infrequent_access,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .reduced_redundancy = "REDUCED_REDUNDANCY",
        .standard_infrequent_access = "STANDARD_IA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .reduced_redundancy => "REDUCED_REDUNDANCY",
            .standard_infrequent_access => "STANDARD_IA",
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
