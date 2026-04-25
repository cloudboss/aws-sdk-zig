const std = @import("std");

/// The status of a registry record in its lifecycle.
pub const RegistryRecordStatus = enum {
    draft,
    pending_approval,
    approved,
    rejected,
    deprecated,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .pending_approval = "PENDING_APPROVAL",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .deprecated = "DEPRECATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .draft => "DRAFT",
            .pending_approval => "PENDING_APPROVAL",
            .approved => "APPROVED",
            .rejected => "REJECTED",
            .deprecated => "DEPRECATED",
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
