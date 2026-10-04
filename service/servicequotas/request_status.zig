const std = @import("std");

pub const RequestStatus = enum {
    pending,
    case_opened,
    approved,
    denied,
    case_closed,
    not_approved,
    invalid_request,

    pub const json_field_names = .{
        .pending = "PENDING",
        .case_opened = "CASE_OPENED",
        .approved = "APPROVED",
        .denied = "DENIED",
        .case_closed = "CASE_CLOSED",
        .not_approved = "NOT_APPROVED",
        .invalid_request = "INVALID_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .case_opened => "CASE_OPENED",
            .approved => "APPROVED",
            .denied => "DENIED",
            .case_closed => "CASE_CLOSED",
            .not_approved => "NOT_APPROVED",
            .invalid_request => "INVALID_REQUEST",
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
