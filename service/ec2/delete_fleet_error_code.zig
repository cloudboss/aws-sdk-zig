const std = @import("std");

pub const DeleteFleetErrorCode = enum {
    fleet_id_does_not_exist,
    fleet_id_malformed,
    fleet_not_in_deletable_state,
    unexpected_error,

    pub const json_field_names = .{
        .fleet_id_does_not_exist = "fleetIdDoesNotExist",
        .fleet_id_malformed = "fleetIdMalformed",
        .fleet_not_in_deletable_state = "fleetNotInDeletableState",
        .unexpected_error = "unexpectedError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fleet_id_does_not_exist => "fleetIdDoesNotExist",
            .fleet_id_malformed => "fleetIdMalformed",
            .fleet_not_in_deletable_state => "fleetNotInDeletableState",
            .unexpected_error => "unexpectedError",
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
