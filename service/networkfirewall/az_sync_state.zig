const Attachment = @import("attachment.zig").Attachment;

/// The status of the firewall endpoint defined by a `VpcEndpointAssociation`.
pub const AZSyncState = struct {
    attachment: ?Attachment = null,

    pub const json_field_names = .{
        .attachment = "Attachment",
    };
};
