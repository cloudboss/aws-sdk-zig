const std = @import("std");

pub const TrustState = enum {
    creating,
    created,
    verifying,
    verify_failed,
    verified,
    updating,
    update_failed,
    updated,
    deleting,
    deleted,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .created = "Created",
        .verifying = "Verifying",
        .verify_failed = "VerifyFailed",
        .verified = "Verified",
        .updating = "Updating",
        .update_failed = "UpdateFailed",
        .updated = "Updated",
        .deleting = "Deleting",
        .deleted = "Deleted",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .created => "Created",
            .verifying => "Verifying",
            .verify_failed => "VerifyFailed",
            .verified => "Verified",
            .updating => "Updating",
            .update_failed => "UpdateFailed",
            .updated => "Updated",
            .deleting => "Deleting",
            .deleted => "Deleted",
            .failed => "Failed",
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
