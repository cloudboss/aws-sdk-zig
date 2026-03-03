const std = @import("std");

pub const AuditEventType = enum {
    case_created,
    case_updated,
    related_item_created,

    pub const json_field_names = .{
        .case_created = "Case.Created",
        .case_updated = "Case.Updated",
        .related_item_created = "RelatedItem.Created",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .case_created => "Case.Created",
            .case_updated => "Case.Updated",
            .related_item_created => "RelatedItem.Created",
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
