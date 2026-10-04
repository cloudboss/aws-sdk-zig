const std = @import("std");

pub const IncludedData = enum {
    all_data,
    metadata_only,

    pub const json_field_names = .{
        .all_data = "AllData",
        .metadata_only = "MetadataOnly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_data => "AllData",
            .metadata_only => "MetadataOnly",
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
