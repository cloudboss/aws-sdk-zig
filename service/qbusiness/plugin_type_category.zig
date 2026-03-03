const std = @import("std");

pub const PluginTypeCategory = enum {
    crm,
    project_management,
    communication,
    productivity,
    ticketing_management,

    pub const json_field_names = .{
        .crm = "Customer relationship management (CRM)",
        .project_management = "Project management",
        .communication = "Communication",
        .productivity = "Productivity",
        .ticketing_management = "Ticketing and incident management",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .crm => "Customer relationship management (CRM)",
            .project_management => "Project management",
            .communication => "Communication",
            .productivity => "Productivity",
            .ticketing_management => "Ticketing and incident management",
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
