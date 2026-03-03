const std = @import("std");

pub const ConfigurationSetFilterName = enum {
    event_destination_name,
    matching_event_types,
    default_message_type,
    default_sender_id,
    default_message_feedback_enabled,
    protect_configuration_id,

    pub const json_field_names = .{
        .event_destination_name = "event-destination-name",
        .matching_event_types = "matching-event-types",
        .default_message_type = "default-message-type",
        .default_sender_id = "default-sender-id",
        .default_message_feedback_enabled = "default-message-feedback-enabled",
        .protect_configuration_id = "protect-configuration-id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_destination_name => "event-destination-name",
            .matching_event_types => "matching-event-types",
            .default_message_type => "default-message-type",
            .default_sender_id => "default-sender-id",
            .default_message_feedback_enabled => "default-message-feedback-enabled",
            .protect_configuration_id => "protect-configuration-id",
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
