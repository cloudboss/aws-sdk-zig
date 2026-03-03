const std = @import("std");

pub const DefinitionType = enum {
    workload_metadata,
    app_registry,

    pub const json_field_names = .{
        .workload_metadata = "WORKLOAD_METADATA",
        .app_registry = "APP_REGISTRY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .workload_metadata => "WORKLOAD_METADATA",
            .app_registry => "APP_REGISTRY",
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
