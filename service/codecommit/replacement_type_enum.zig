const std = @import("std");

pub const ReplacementTypeEnum = enum {
    keep_base,
    keep_source,
    keep_destination,
    use_new_content,

    pub const json_field_names = .{
        .keep_base = "KEEP_BASE",
        .keep_source = "KEEP_SOURCE",
        .keep_destination = "KEEP_DESTINATION",
        .use_new_content = "USE_NEW_CONTENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .keep_base => "KEEP_BASE",
            .keep_source => "KEEP_SOURCE",
            .keep_destination => "KEEP_DESTINATION",
            .use_new_content => "USE_NEW_CONTENT",
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
