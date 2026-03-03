const std = @import("std");

pub const RegistrationStatus = enum {
    created,
    submitted,
    aws_reviewing,
    reviewing,
    requires_authentication,
    provisioning,
    complete,
    requires_updates,
    closed,
    deleted,

    pub const json_field_names = .{
        .created = "CREATED",
        .submitted = "SUBMITTED",
        .aws_reviewing = "AWS_REVIEWING",
        .reviewing = "REVIEWING",
        .requires_authentication = "REQUIRES_AUTHENTICATION",
        .provisioning = "PROVISIONING",
        .complete = "COMPLETE",
        .requires_updates = "REQUIRES_UPDATES",
        .closed = "CLOSED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .submitted => "SUBMITTED",
            .aws_reviewing => "AWS_REVIEWING",
            .reviewing => "REVIEWING",
            .requires_authentication => "REQUIRES_AUTHENTICATION",
            .provisioning => "PROVISIONING",
            .complete => "COMPLETE",
            .requires_updates => "REQUIRES_UPDATES",
            .closed => "CLOSED",
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
