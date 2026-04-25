const std = @import("std");

pub const ApproverLastActivity = enum {
    voted,
    baselined,
    responded_to_invitation,

    pub const json_field_names = .{
        .voted = "VOTED",
        .baselined = "BASELINED",
        .responded_to_invitation = "RESPONDED_TO_INVITATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .voted => "VOTED",
            .baselined => "BASELINED",
            .responded_to_invitation => "RESPONDED_TO_INVITATION",
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
