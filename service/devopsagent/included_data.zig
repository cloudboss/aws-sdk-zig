const std = @import("std");

/// How much data to include in the response. Defaults to ALL_DATA.
pub const IncludedData = enum {
    metadata_only,
    all_data,

    pub const json_field_names = .{
        .metadata_only = "METADATA_ONLY",
        .all_data = "ALL_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .metadata_only => "METADATA_ONLY",
            .all_data => "ALL_DATA",
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
