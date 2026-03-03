const std = @import("std");

pub const FlowTemplateFilterName = enum {
    device_model_id,

    pub const json_field_names = .{
        .device_model_id = "DEVICE_MODEL_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .device_model_id => "DEVICE_MODEL_ID",
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
