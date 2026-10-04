const std = @import("std");

pub const TaskTemplateFieldType = enum {
    name,
    description,
    scheduled_time,
    quick_connect,
    url,
    number,
    text,
    text_area,
    date_time,
    boolean,
    single_select,
    email,
    self_assign,
    expiry_duration,

    pub const json_field_names = .{
        .name = "NAME",
        .description = "DESCRIPTION",
        .scheduled_time = "SCHEDULED_TIME",
        .quick_connect = "QUICK_CONNECT",
        .url = "URL",
        .number = "NUMBER",
        .text = "TEXT",
        .text_area = "TEXT_AREA",
        .date_time = "DATE_TIME",
        .boolean = "BOOLEAN",
        .single_select = "SINGLE_SELECT",
        .email = "EMAIL",
        .self_assign = "SELF_ASSIGN",
        .expiry_duration = "EXPIRY_DURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .description => "DESCRIPTION",
            .scheduled_time => "SCHEDULED_TIME",
            .quick_connect => "QUICK_CONNECT",
            .url => "URL",
            .number => "NUMBER",
            .text => "TEXT",
            .text_area => "TEXT_AREA",
            .date_time => "DATE_TIME",
            .boolean => "BOOLEAN",
            .single_select => "SINGLE_SELECT",
            .email => "EMAIL",
            .self_assign => "SELF_ASSIGN",
            .expiry_duration => "EXPIRY_DURATION",
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
