const std = @import("std");

/// Used in CreateNodeRequest, CreateNodeRegistrationScriptRequest,
/// DescribeNodeResult, DescribeNodeSummary, UpdateNodeRequest.
pub const NodeRole = enum {
    backup,
    active,

    pub const json_field_names = .{
        .backup = "BACKUP",
        .active = "ACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .backup => "BACKUP",
            .active => "ACTIVE",
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
