const std = @import("std");

pub const SlotTypeFilterName = enum {
    slot_type_name,
    external_source_type,

    pub const json_field_names = .{
        .slot_type_name = "SlotTypeName",
        .external_source_type = "ExternalSourceType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .slot_type_name => "SlotTypeName",
            .external_source_type => "ExternalSourceType",
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
