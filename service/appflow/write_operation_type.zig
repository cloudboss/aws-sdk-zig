const std = @import("std");

/// The possible write operations in the destination connector. When this value
/// is not
/// provided, this defaults to the `INSERT` operation.
pub const WriteOperationType = enum {
    insert,
    upsert,
    update,
    delete,

    pub const json_field_names = .{
        .insert = "INSERT",
        .upsert = "UPSERT",
        .update = "UPDATE",
        .delete = "DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
            .upsert => "UPSERT",
            .update => "UPDATE",
            .delete => "DELETE",
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
