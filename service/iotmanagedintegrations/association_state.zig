const std = @import("std");

pub const AssociationState = enum {
    association_in_progress,
    association_failed,
    association_succeeded,
    association_deleting,
    refresh_token_expired,

    pub const json_field_names = .{
        .association_in_progress = "ASSOCIATION_IN_PROGRESS",
        .association_failed = "ASSOCIATION_FAILED",
        .association_succeeded = "ASSOCIATION_SUCCEEDED",
        .association_deleting = "ASSOCIATION_DELETING",
        .refresh_token_expired = "REFRESH_TOKEN_EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .association_in_progress => "ASSOCIATION_IN_PROGRESS",
            .association_failed => "ASSOCIATION_FAILED",
            .association_succeeded => "ASSOCIATION_SUCCEEDED",
            .association_deleting => "ASSOCIATION_DELETING",
            .refresh_token_expired => "REFRESH_TOKEN_EXPIRED",
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
