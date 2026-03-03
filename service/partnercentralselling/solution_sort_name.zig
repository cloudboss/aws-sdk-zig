const std = @import("std");

pub const SolutionSortName = enum {
    identifier,
    name,
    status,
    category,
    createddate,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .name = "Name",
        .status = "Status",
        .category = "Category",
        .createddate = "CreatedDate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identifier => "Identifier",
            .name => "Name",
            .status => "Status",
            .category => "Category",
            .createddate => "CreatedDate",
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
