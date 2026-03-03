const std = @import("std");

pub const InventorySchemaDeleteOption = enum {
    disable_schema,
    delete_schema,

    pub const json_field_names = .{
        .disable_schema = "DisableSchema",
        .delete_schema = "DeleteSchema",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disable_schema => "DisableSchema",
            .delete_schema => "DeleteSchema",
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
