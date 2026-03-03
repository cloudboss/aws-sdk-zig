const std = @import("std");

pub const ModificationResourceEnum = enum {
    root_volume,
    user_volume,
    compute_type,

    pub const json_field_names = .{
        .root_volume = "ROOT_VOLUME",
        .user_volume = "USER_VOLUME",
        .compute_type = "COMPUTE_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .root_volume => "ROOT_VOLUME",
            .user_volume => "USER_VOLUME",
            .compute_type => "COMPUTE_TYPE",
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
