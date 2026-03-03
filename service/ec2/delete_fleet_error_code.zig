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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
