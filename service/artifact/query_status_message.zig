const std = @import("std");

pub const QueryStatusMessage = enum {
    success,
    in_progress,
    internal_error,
    pending_human_review,
    restricted,

    pub const json_field_names = .{
        .success = "Query processing is complete.",
        .in_progress = "Query processing is in-progress.",
        .internal_error = "An internal error occurred while processing the query. Try again at a later time.",
        .pending_human_review = "Query is pending human review.",
        .restricted = "Query contains restricted or unsupported content.",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "Query processing is complete.",
            .in_progress => "Query processing is in-progress.",
            .internal_error => "An internal error occurred while processing the query. Try again at a later time.",
            .pending_human_review => "Query is pending human review.",
            .restricted => "Query contains restricted or unsupported content.",
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
