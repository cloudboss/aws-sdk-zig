const std = @import("std");

pub const TypesSearchScope = enum {
    asset_type,
    form_type,
    lineage_node_type,

    pub const json_field_names = .{
        .asset_type = "ASSET_TYPE",
        .form_type = "FORM_TYPE",
        .lineage_node_type = "LINEAGE_NODE_TYPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asset_type => "ASSET_TYPE",
            .form_type => "FORM_TYPE",
            .lineage_node_type => "LINEAGE_NODE_TYPE",
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
