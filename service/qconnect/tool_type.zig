const std = @import("std");

pub const ToolType = enum {
    model_context_protocol,
    return_to_control,
    constant,

    pub const json_field_names = .{
        .model_context_protocol = "MODEL_CONTEXT_PROTOCOL",
        .return_to_control = "RETURN_TO_CONTROL",
        .constant = "CONSTANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .model_context_protocol => "MODEL_CONTEXT_PROTOCOL",
            .return_to_control => "RETURN_TO_CONTROL",
            .constant => "CONSTANT",
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
