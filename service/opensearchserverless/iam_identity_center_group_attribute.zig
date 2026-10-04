const std = @import("std");

pub const IamIdentityCenterGroupAttribute = enum {
    /// Group ID
    group_id,
    /// Group Name
    group_name,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .group_id => "GroupId",
            .group_name => "GroupName",
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
