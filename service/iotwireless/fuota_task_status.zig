const std = @import("std");

/// The status of a FUOTA task.
pub const FuotaTaskStatus = enum {
    pending,
    fuota_session_waiting,
    in_fuota_session,
    fuota_done,
    delete_waiting,

    pub const json_field_names = .{
        .pending = "Pending",
        .fuota_session_waiting = "FuotaSession_Waiting",
        .in_fuota_session = "In_FuotaSession",
        .fuota_done = "FuotaDone",
        .delete_waiting = "Delete_Waiting",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .fuota_session_waiting => "FuotaSession_Waiting",
            .in_fuota_session => "In_FuotaSession",
            .fuota_done => "FuotaDone",
            .delete_waiting => "Delete_Waiting",
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
