const std = @import("std");

pub const AssetModelType = enum {
    asset_model,
    component_model,
    interface,

    pub const json_field_names = .{
        .asset_model = "ASSET_MODEL",
        .component_model = "COMPONENT_MODEL",
        .interface = "INTERFACE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asset_model => "ASSET_MODEL",
            .component_model => "COMPONENT_MODEL",
            .interface => "INTERFACE",
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
