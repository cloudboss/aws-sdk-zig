const std = @import("std");

pub const DeletionProtection = enum {
    none,
    prevent_force_deletion,
    prevent_all_deletion,

    pub const json_field_names = .{
        .none = "none",
        .prevent_force_deletion = "prevent-force-deletion",
        .prevent_all_deletion = "prevent-all-deletion",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .prevent_force_deletion => "prevent-force-deletion",
            .prevent_all_deletion => "prevent-all-deletion",
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
