const std = @import("std");

pub const ActionCode = enum {
    archive_retrieval,
    inventory_retrieval,
    select,

    pub const json_field_names = .{
        .archive_retrieval = "ArchiveRetrieval",
        .inventory_retrieval = "InventoryRetrieval",
        .select = "Select",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .archive_retrieval => "ArchiveRetrieval",
            .inventory_retrieval => "InventoryRetrieval",
            .select => "Select",
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
