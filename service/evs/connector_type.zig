const std = @import("std");

pub const ConnectorType = enum {
    operations_manager,
    sddc_manager,
    vcenter,

    pub const json_field_names = .{
        .operations_manager = "OPERATIONS_MANAGER",
        .sddc_manager = "SDDC_MANAGER",
        .vcenter = "VCENTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .operations_manager => "OPERATIONS_MANAGER",
            .sddc_manager => "SDDC_MANAGER",
            .vcenter => "VCENTER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
