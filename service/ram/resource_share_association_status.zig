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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
