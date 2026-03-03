const std = @import("std");

pub const GroupName = enum {
    external_id,
    external_source_type,

    pub const json_field_names = .{
        .external_id = "ExternalId",
        .external_source_type = "ExternalSourceType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .external_id => "ExternalId",
            .external_source_type => "ExternalSourceType",
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
