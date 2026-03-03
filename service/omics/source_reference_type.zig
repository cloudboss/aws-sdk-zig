const std = @import("std");

pub const SourceReferenceType = enum {
    branch,
    tag,
    commit,

    pub const json_field_names = .{
        .branch = "BRANCH",
        .tag = "TAG",
        .commit = "COMMIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .branch => "BRANCH",
            .tag => "TAG",
            .commit => "COMMIT",
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
