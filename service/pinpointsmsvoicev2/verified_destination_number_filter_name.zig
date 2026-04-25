const std = @import("std");

/// The filter name for filtering verified destination numbers. The available
/// filter names are:
///
/// * `status`: Filter by verification status.
/// * `rcs-agent-id`: Filter by the RCS agent identifier.
pub const VerifiedDestinationNumberFilterName = enum {
    status,
    rcs_agent_id,

    pub const json_field_names = .{
        .status = "status",
        .rcs_agent_id = "rcs-agent-id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .status => "status",
            .rcs_agent_id => "rcs-agent-id",
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
