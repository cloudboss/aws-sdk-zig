const std = @import("std");

/// Elemental Inference Feed management state.
pub const ElementalInferenceFeedManagementState = enum {
    created,
    associated,
    pending_deletion,
    deleted,

    pub const json_field_names = .{
        .created = "CREATED",
        .associated = "ASSOCIATED",
        .pending_deletion = "PENDING_DELETION",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .associated => "ASSOCIATED",
            .pending_deletion => "PENDING_DELETION",
            .deleted => "DELETED",
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
