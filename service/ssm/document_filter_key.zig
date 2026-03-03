const std = @import("std");

pub const DocumentFilterKey = enum {
    name,
    owner,
    platform_types,
    document_type,

    pub const json_field_names = .{
        .name = "Name",
        .owner = "Owner",
        .platform_types = "PlatformTypes",
        .document_type = "DocumentType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .owner => "Owner",
            .platform_types => "PlatformTypes",
            .document_type => "DocumentType",
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
