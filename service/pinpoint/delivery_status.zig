const std = @import("std");

pub const DeliveryStatus = enum {
    successful,
    throttled,
    temporary_failure,
    permanent_failure,
    unknown_failure,
    opt_out,
    duplicate,

    pub const json_field_names = .{
        .successful = "SUCCESSFUL",
        .throttled = "THROTTLED",
        .temporary_failure = "TEMPORARY_FAILURE",
        .permanent_failure = "PERMANENT_FAILURE",
        .unknown_failure = "UNKNOWN_FAILURE",
        .opt_out = "OPT_OUT",
        .duplicate = "DUPLICATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .successful => "SUCCESSFUL",
            .throttled => "THROTTLED",
            .temporary_failure => "TEMPORARY_FAILURE",
            .permanent_failure => "PERMANENT_FAILURE",
            .unknown_failure => "UNKNOWN_FAILURE",
            .opt_out => "OPT_OUT",
            .duplicate => "DUPLICATE",
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
