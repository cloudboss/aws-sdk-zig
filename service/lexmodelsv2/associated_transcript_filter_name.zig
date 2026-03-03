const std = @import("std");

pub const AssociatedTranscriptFilterName = enum {
    intent_id,
    slot_type_id,

    pub const json_field_names = .{
        .intent_id = "IntentId",
        .slot_type_id = "SlotTypeId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .intent_id => "IntentId",
            .slot_type_id => "SlotTypeId",
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
