const std = @import("std");

pub const DescribeWorkspaceDirectoriesFilterName = enum {
    user_identity_type,
    workspace_type,

    pub const json_field_names = .{
        .user_identity_type = "USER_IDENTITY_TYPE",
        .workspace_type = "WORKSPACE_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_identity_type => "USER_IDENTITY_TYPE",
            .workspace_type => "WORKSPACE_TYPE",
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
