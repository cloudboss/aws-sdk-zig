const std = @import("std");

pub const WafStatus = enum {
    associating,
    association_failed,
    association_success,
    disassociating,
    disassociation_failed,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .association_failed = "ASSOCIATION_FAILED",
        .association_success = "ASSOCIATION_SUCCESS",
        .disassociating = "DISASSOCIATING",
        .disassociation_failed = "DISASSOCIATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associating => "ASSOCIATING",
            .association_failed => "ASSOCIATION_FAILED",
            .association_success => "ASSOCIATION_SUCCESS",
            .disassociating => "DISASSOCIATING",
            .disassociation_failed => "DISASSOCIATION_FAILED",
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
