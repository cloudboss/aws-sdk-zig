const std = @import("std");

/// The state of a VPC connection.
pub const VpcConnectionState = enum {
    creating,
    available,
    inactive,
    deactivating,
    deleting,
    failed,
    rejected,
    rejecting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .inactive = "INACTIVE",
        .deactivating = "DEACTIVATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .rejected = "REJECTED",
        .rejecting = "REJECTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .available => "AVAILABLE",
            .inactive => "INACTIVE",
            .deactivating => "DEACTIVATING",
            .deleting => "DELETING",
            .failed => "FAILED",
            .rejected => "REJECTED",
            .rejecting => "REJECTING",
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
