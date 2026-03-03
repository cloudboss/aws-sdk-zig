const std = @import("std");

pub const MarketplaceResourceType = enum {
    component_data,
    component_artifact,

    pub const json_field_names = .{
        .component_data = "COMPONENT_DATA",
        .component_artifact = "COMPONENT_ARTIFACT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .component_data => "COMPONENT_DATA",
            .component_artifact => "COMPONENT_ARTIFACT",
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
