const std = @import("std");

/// The status of a support permit request.
pub const SupportPermitRequestStatus = enum {
    /// The request is pending customer review.
    pending,
    /// The request has been accepted.
    accepted,
    /// The request has been rejected.
    rejected,
    /// The request has been cancelled.
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .accepted = "ACCEPTED",
        .rejected = "REJECTED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .accepted => "ACCEPTED",
            .rejected => "REJECTED",
            .cancelled => "CANCELLED",
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
