const std = @import("std");

pub const SuggestIntendedUse = enum {
    /// Indicates that results of the operation are for single use, e.g., displaying
    /// results on a map or presenting options to users.
    single_use,

    pub const json_field_names = .{
        .single_use = "SingleUse",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_use => "SingleUse",
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
