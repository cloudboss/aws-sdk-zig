const std = @import("std");

pub const ResourceType = enum {
    contact,
    contact_flow,
    instance,
    participant,
    hierarchy_level,
    hierarchy_group,
    user,
    phone_number,

    pub const json_field_names = .{
        .contact = "CONTACT",
        .contact_flow = "CONTACT_FLOW",
        .instance = "INSTANCE",
        .participant = "PARTICIPANT",
        .hierarchy_level = "HIERARCHY_LEVEL",
        .hierarchy_group = "HIERARCHY_GROUP",
        .user = "USER",
        .phone_number = "PHONE_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contact => "CONTACT",
            .contact_flow => "CONTACT_FLOW",
            .instance => "INSTANCE",
            .participant => "PARTICIPANT",
            .hierarchy_level => "HIERARCHY_LEVEL",
            .hierarchy_group => "HIERARCHY_GROUP",
            .user => "USER",
            .phone_number => "PHONE_NUMBER",
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
