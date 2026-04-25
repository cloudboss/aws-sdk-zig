const std = @import("std");

/// DataAutomationLibraryIngestionJob operation type
pub const LibraryIngestionJobOperationType = enum {
    upsert,
    delete,

    pub const json_field_names = .{
        .upsert = "UPSERT",
        .delete = "DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .upsert => "UPSERT",
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
