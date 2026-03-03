const std = @import("std");

pub const ResourceShareAssociationStatus = enum {
    associating,
    associated,
    failed,
    disassociating,
    disassociated,
    suspended,
    suspending,
    restoring,

    pub const json_field_names = .{
        .associating = "ASSOCIATING",
        .associated = "ASSOCIATED",
        .failed = "FAILED",
        .disassociating = "DISASSOCIATING",
        .disassociated = "DISASSOCIATED",
        .suspended = "SUSPENDED",
        .suspending = "SUSPENDING",
        .restoring = "RESTORING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associating => "ASSOCIATING",
            .associated => "ASSOCIATED",
            .failed => "FAILED",
            .disassociating => "DISASSOCIATING",
            .disassociated => "DISASSOCIATED",
            .suspended => "SUSPENDED",
            .suspending => "SUSPENDING",
            .restoring => "RESTORING",
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
