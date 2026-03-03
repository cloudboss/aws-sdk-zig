const std = @import("std");

/// The deployment status of a resource. Status can be one of the following:
///
/// PENDING: Amazon Route 53 Application Recovery Controller is creating the
/// resource.
///
/// DEPLOYED: The resource is deployed and ready to use.
///
/// PENDING_DELETION: Amazon Route 53 Application Recovery Controller is
/// deleting the resource.
pub const Status = enum {
    pending,
    deployed,
    pending_deletion,

    pub const json_field_names = .{
        .pending = "PENDING",
        .deployed = "DEPLOYED",
        .pending_deletion = "PENDING_DELETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .deployed => "DEPLOYED",
            .pending_deletion => "PENDING_DELETION",
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
