const std = @import("std");

/// The current metric names.
pub const CurrentMetricName = enum {
    agents_online,
    agents_available,
    agents_on_call,
    agents_non_productive,
    agents_after_contact_work,
    agents_error,
    agents_staffed,
    contacts_in_queue,
    oldest_contact_age,
    contacts_scheduled,
    agents_on_contact,
    slots_active,
    slots_available,
    estimated_wait_time,

    pub const json_field_names = .{
        .agents_online = "AGENTS_ONLINE",
        .agents_available = "AGENTS_AVAILABLE",
        .agents_on_call = "AGENTS_ON_CALL",
        .agents_non_productive = "AGENTS_NON_PRODUCTIVE",
        .agents_after_contact_work = "AGENTS_AFTER_CONTACT_WORK",
        .agents_error = "AGENTS_ERROR",
        .agents_staffed = "AGENTS_STAFFED",
        .contacts_in_queue = "CONTACTS_IN_QUEUE",
        .oldest_contact_age = "OLDEST_CONTACT_AGE",
        .contacts_scheduled = "CONTACTS_SCHEDULED",
        .agents_on_contact = "AGENTS_ON_CONTACT",
        .slots_active = "SLOTS_ACTIVE",
        .slots_available = "SLOTS_AVAILABLE",
        .estimated_wait_time = "ESTIMATED_WAIT_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agents_online => "AGENTS_ONLINE",
            .agents_available => "AGENTS_AVAILABLE",
            .agents_on_call => "AGENTS_ON_CALL",
            .agents_non_productive => "AGENTS_NON_PRODUCTIVE",
            .agents_after_contact_work => "AGENTS_AFTER_CONTACT_WORK",
            .agents_error => "AGENTS_ERROR",
            .agents_staffed => "AGENTS_STAFFED",
            .contacts_in_queue => "CONTACTS_IN_QUEUE",
            .oldest_contact_age => "OLDEST_CONTACT_AGE",
            .contacts_scheduled => "CONTACTS_SCHEDULED",
            .agents_on_contact => "AGENTS_ON_CONTACT",
            .slots_active => "SLOTS_ACTIVE",
            .slots_available => "SLOTS_AVAILABLE",
            .estimated_wait_time => "ESTIMATED_WAIT_TIME",
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
