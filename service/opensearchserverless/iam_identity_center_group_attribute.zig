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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
