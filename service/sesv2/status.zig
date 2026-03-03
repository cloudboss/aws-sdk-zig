const std = @import("std");

/// The status of the multi-region endpoint (global-endpoint).
///
/// * `CREATING` – The resource is being provisioned.
///
/// * `READY` – The resource is ready to use.
///
/// * `FAILED` – The resource failed to be provisioned.
///
/// * `DELETING` – The resource is being deleted as requested.
pub const Status = enum {
    creating,
    ready,
    failed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .ready = "READY",
        .failed = "FAILED",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .ready => "READY",
            .failed => "FAILED",
            .deleting => "DELETING",
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
