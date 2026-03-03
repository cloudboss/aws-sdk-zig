const std = @import("std");

pub const RepositoryTriggerEventEnum = enum {
    all,
    update_reference,
    create_reference,
    delete_reference,

    pub const json_field_names = .{
        .all = "all",
        .update_reference = "updateReference",
        .create_reference = "createReference",
        .delete_reference = "deleteReference",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "all",
            .update_reference => "updateReference",
            .create_reference => "createReference",
            .delete_reference => "deleteReference",
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
