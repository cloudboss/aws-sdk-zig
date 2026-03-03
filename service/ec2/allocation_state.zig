const std = @import("std");

pub const AllocationState = enum {
    available,
    under_assessment,
    permanent_failure,
    released,
    released_permanent_failure,
    pending,

    pub const json_field_names = .{
        .available = "available",
        .under_assessment = "under-assessment",
        .permanent_failure = "permanent-failure",
        .released = "released",
        .released_permanent_failure = "released-permanent-failure",
        .pending = "pending",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "available",
            .under_assessment => "under-assessment",
            .permanent_failure => "permanent-failure",
            .released => "released",
            .released_permanent_failure => "released-permanent-failure",
            .pending => "pending",
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
