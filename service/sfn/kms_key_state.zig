const std = @import("std");

pub const KmsKeyState = enum {
    disabled,
    pending_deletion,
    pending_import,
    unavailable,
    creating,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .pending_deletion = "PENDING_DELETION",
        .pending_import = "PENDING_IMPORT",
        .unavailable = "UNAVAILABLE",
        .creating = "CREATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .pending_deletion => "PENDING_DELETION",
            .pending_import => "PENDING_IMPORT",
            .unavailable => "UNAVAILABLE",
            .creating => "CREATING",
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
