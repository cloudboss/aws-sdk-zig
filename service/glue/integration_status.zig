const std = @import("std");

pub const IntegrationStatus = enum {
    creating,
    active,
    modifying,
    failed,
    deleting,
    syncing,
    needs_attention,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .modifying = "MODIFYING",
        .failed = "FAILED",
        .deleting = "DELETING",
        .syncing = "SYNCING",
        .needs_attention = "NEEDS_ATTENTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .active => "ACTIVE",
            .modifying => "MODIFYING",
            .failed => "FAILED",
            .deleting => "DELETING",
            .syncing => "SYNCING",
            .needs_attention => "NEEDS_ATTENTION",
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
