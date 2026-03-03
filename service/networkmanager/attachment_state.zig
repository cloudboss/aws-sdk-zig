const std = @import("std");

pub const AttachmentState = enum {
    rejected,
    pending_attachment_acceptance,
    creating,
    failed,
    available,
    updating,
    pending_network_update,
    pending_tag_acceptance,
    deleting,

    pub const json_field_names = .{
        .rejected = "REJECTED",
        .pending_attachment_acceptance = "PENDING_ATTACHMENT_ACCEPTANCE",
        .creating = "CREATING",
        .failed = "FAILED",
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .pending_network_update = "PENDING_NETWORK_UPDATE",
        .pending_tag_acceptance = "PENDING_TAG_ACCEPTANCE",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rejected => "REJECTED",
            .pending_attachment_acceptance => "PENDING_ATTACHMENT_ACCEPTANCE",
            .creating => "CREATING",
            .failed => "FAILED",
            .available => "AVAILABLE",
            .updating => "UPDATING",
            .pending_network_update => "PENDING_NETWORK_UPDATE",
            .pending_tag_acceptance => "PENDING_TAG_ACCEPTANCE",
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
