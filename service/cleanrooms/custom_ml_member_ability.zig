const std = @import("std");

pub const CustomMLMemberAbility = enum {
    can_receive_model_output,
    can_receive_inference_output,

    pub const json_field_names = .{
        .can_receive_model_output = "CAN_RECEIVE_MODEL_OUTPUT",
        .can_receive_inference_output = "CAN_RECEIVE_INFERENCE_OUTPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .can_receive_model_output => "CAN_RECEIVE_MODEL_OUTPUT",
            .can_receive_inference_output => "CAN_RECEIVE_INFERENCE_OUTPUT",
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
