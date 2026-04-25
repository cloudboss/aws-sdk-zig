const std = @import("std");

/// The strategy for assigning IP addresses during the enrichment process.
/// STATIC assigns fixed IP addresses, while DYNAMIC allows for dynamic IP
/// allocation.
pub const IpAssignmentStrategy = enum {
    static,
    dynamic,

    pub const json_field_names = .{
        .static = "STATIC",
        .dynamic = "DYNAMIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .static => "STATIC",
            .dynamic => "DYNAMIC",
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
