const std = @import("std");

pub const DomainPackageStatus = enum {
    associating,
    association_failed,
    active,
    dissociating,
    dissociation_failed,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .association_failed = "ASSOCIATION_FAILED",
        .active = "ACTIVE",
        .dissociating = "DISSOCIATING",
        .dissociation_failed = "DISSOCIATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associating => "ASSOCIATING",
            .association_failed => "ASSOCIATION_FAILED",
            .active => "ACTIVE",
            .dissociating => "DISSOCIATING",
            .dissociation_failed => "DISSOCIATION_FAILED",
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
