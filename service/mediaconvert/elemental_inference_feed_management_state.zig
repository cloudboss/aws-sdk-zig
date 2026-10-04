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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
