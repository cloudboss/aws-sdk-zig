const std = @import("std");

/// Enumeration of the policies to enact on existing campaigns during instance
/// config deletion
pub const CampaignDeletionPolicy = enum {
    retain_all,
    delete_all,

    pub const json_field_names = .{
        .retain_all = "RETAIN_ALL",
        .delete_all = "DELETE_ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .retain_all => "RETAIN_ALL",
            .delete_all => "DELETE_ALL",
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
